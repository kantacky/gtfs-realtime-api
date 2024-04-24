package model

import (
	"database/sql/driver"
	"encoding/json"
	"errors"
	"fmt"
	"strconv"
	"strings"
	"unsafe"
)

type Coordinate struct {
	Latitude  float32
	Longitude float32
}

func (coordinate *Coordinate) Scan(value interface{}) error {
	var result string

	switch v := value.(type) {
	case []byte:
		result = *(*string)(unsafe.Pointer(&v))
	case string:
		result = v
	default:
		return errors.New("invalid type")
	}

	result = strings.ReplaceAll(result, "(", "")
	result = strings.ReplaceAll(result, ")", "")
	latLng := strings.Split(result, ",")
	latitude, _ := strconv.ParseFloat(latLng[0], 32)
	longitude, _ := strconv.ParseFloat(latLng[1], 32)
	coordinate = &Coordinate{
		Latitude:  float32(latitude),
		Longitude: float32(longitude),
	}

	return nil
}

func (coordinate Coordinate) Value() (driver.Value, error) {
	return json.RawMessage(
		fmt.Sprintf(
			"POINT(%f,%f)",
			coordinate.Latitude,
			coordinate.Longitude,
		),
	).MarshalJSON()
}
