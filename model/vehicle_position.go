package model

import (
	"time"
)

type VehiclePosition struct {
	ID                   string      `gorm:"column:id;primary_key"`
	TripID               *string     `gorm:"column:trip_id"`
	RouteID              *string     `gorm:"column:route_id"`
	DirectionID          *int32      `gorm:"column:direction_id"`
	StartDatetime        *time.Time  `gorm:"column:start_datetime"`
	ScheduleRelationship *string     `gorm:"column:schedule_relationship"`
	VehicleID            *string     `gorm:"column:vehicle_id"`
	VehicleLabel         *string     `gorm:"column:vehicle_label"`
	VehiclePosition      *Coordinate `gorm:"column:vehicle_position"`
	CurrentStopSequence  *int32      `gorm:"column:current_stop_sequence"`
	StopID               *string     `gorm:"column:stop_id"`
	Timestamp            *time.Time  `gorm:"column:timestamp"`
}
