package lib

import (
	"time"

	"google.golang.org/protobuf/types/known/timestamppb"
)

func TimestampPB(timestamp *time.Time) *timestamppb.Timestamp {
	if timestamp == nil {
		return nil
	}
	return timestamppb.New(*timestamp)
}
