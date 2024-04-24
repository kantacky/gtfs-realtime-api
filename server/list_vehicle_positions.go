package server

import (
	context "context"
	"fmt"
	"log"
	"sort"
	"strings"
	"time"

	"github.com/kantacky/gtfs-realtime-api/lib"
	"github.com/kantacky/gtfs-realtime-api/model"
)

func (s *gtfsRealtimeServiceServer) ListVehiclePositions(
	ctx context.Context,
	req *ListVehiclePositionsRequest,
) (*ListVehiclePositionsResponse, error) {
	db, err := lib.GetSQLDB()
	if err != nil {
		log.Fatalln("lib.GetSQLDB error:", err)
	}
	defer db.Close()

	gormDB, err := lib.GetGORMDB(db)
	if err != nil {
		log.Fatalln("lib.GetGORMDB error:", err)
	}

	bufferSeconds := time.Duration(req.GetBufferSeconds()) * time.Second
	timestampFrom := req.GetTimestamp().AsTime().Local().Add(-bufferSeconds)
	timestampTo := req.GetTimestamp().AsTime().Local()

	schemaName := fmt.Sprintf("a%s", strings.ReplaceAll(req.GetAgencyId(), "-", ""))

	results := []model.VehiclePosition{}
	if err := gormDB.Select(
		"DISTINCT ON (vehicle_id) *",
	).Table(
		fmt.Sprintf("%s.vehicle_positions", schemaName),
	).Where(
		"timestamp >= ? AND timestamp <= ?",
		lib.ISO8601(timestampFrom),
		lib.ISO8601(timestampTo),
	).Order(
		"vehicle_id ASC, timestamp DESC",
	).Find(&results).Error; err != nil {
		return nil, err
	}

	sort.Slice(results, func(i, j int) bool {
		return results[i].Timestamp.After(*results[j].Timestamp)
	})

	vehiclePositions := []*VehiclePosition{}
	for _, result := range results {
		vehiclePositions = append(
			vehiclePositions,
			&VehiclePosition{
				Id:                   result.ID,
				TripId:               result.TripID,
				RouteId:              result.RouteID,
				DirectionId:          result.DirectionID,
				StartDatetime:        lib.TimestampPB(result.StartDatetime),
				ScheduleRelationship: result.ScheduleRelationship,
				VehicleId:            result.VehicleID,
				VehicleLabel:         result.VehicleLabel,
				VehiclePosition: &Coordinate{
					Latitude:  result.VehiclePosition.Latitude,
					Longitude: result.VehiclePosition.Longitude,
				},
				CurrentStopSequence: result.CurrentStopSequence,
				StopId:              result.StopID,
				Timestamp:           lib.TimestampPB(result.Timestamp),
			},
		)
	}

	return &ListVehiclePositionsResponse{
		VehiclePositions: vehiclePositions,
	}, nil
}
