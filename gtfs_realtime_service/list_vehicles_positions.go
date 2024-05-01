package gtfs_realtime_service

import (
	context "context"
	"fmt"
	"log"
	"sort"
	"strings"
	"time"

	"connectrpc.com/connect"
	foundationv1 "github.com/kantacky/apis-go/kantacky/foundation/v1"
	gtfs_realtimev1 "github.com/kantacky/apis-go/research/gtfs_realtime/v1"
	"github.com/kantacky/gtfs-realtime-api/lib"
	"github.com/kantacky/gtfs-realtime-api/model"
)

func (s *GTFSRealtimeService) ListVehiclesPositions(
	ctx context.Context,
	req *connect.Request[gtfs_realtimev1.ListVehiclesPositionsRequest],
) (
	res *connect.Response[gtfs_realtimev1.ListVehiclesPositionsResponse],
	err error,
) {
	res = connect.NewResponse(&gtfs_realtimev1.ListVehiclesPositionsResponse{})
	res.Header().Set("GTFSRealtime-Version", "v1")

	db, err := lib.GetSQLDB()
	if err != nil {
		log.Fatalln("lib.GetSQLDB error:", err)
	}
	defer db.Close()

	gormDB, err := lib.GetGORMDB(db)
	if err != nil {
		log.Fatalln("lib.GetGORMDB error:", err)
	}

	bufferDuration := time.Duration(req.Msg.GetBufferSeconds()) * time.Second
	timestampFrom := req.Msg.GetTimestamp().AsTime().Local().Add(-bufferDuration)
	timestampTo := req.Msg.GetTimestamp().AsTime().Local()

	schemaName := fmt.Sprintf("a%s", strings.ToLower(strings.ReplaceAll(req.Msg.GetAgencyId(), "-", "")))

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
		message := fmt.Sprintf("gormDB.Find error: %v", err)
		res.Msg = &gtfs_realtimev1.ListVehiclesPositionsResponse{
			Result: &foundationv1.Result{
				Status:  foundationv1.ResultStatus_RESULT_STATUS_FAILURE,
				Message: &message,
			},
		}
		return res, nil
	}

	sort.Slice(results, func(i, j int) bool {
		return results[i].Timestamp.After(*results[j].Timestamp)
	})

	vehiclePositions := []*gtfs_realtimev1.VehiclePosition{}
	for _, result := range results {
		vehiclePositions = append(
			vehiclePositions,
			&gtfs_realtimev1.VehiclePosition{
				Id:                   result.ID,
				TripId:               result.TripID,
				RouteId:              result.RouteID,
				DirectionId:          result.DirectionID,
				StartDatetime:        lib.TimestampPB(result.StartDatetime),
				ScheduleRelationship: result.ScheduleRelationship,
				VehicleId:            result.VehicleID,
				VehicleLabel:         result.VehicleLabel,
				VehiclePosition: &foundationv1.Coordinate{
					Latitude:  result.VehiclePosition.Latitude,
					Longitude: result.VehiclePosition.Longitude,
				},
				CurrentStopSequence: result.CurrentStopSequence,
				StopId:              result.StopID,
				Timestamp:           lib.TimestampPB(result.Timestamp),
			},
		)
	}

	res.Msg = &gtfs_realtimev1.ListVehiclesPositionsResponse{
		Result: &foundationv1.Result{
			Status: foundationv1.ResultStatus_RESULT_STATUS_SUCCESS,
		},
		VehiclePositions: vehiclePositions,
	}

	return res, nil
}
