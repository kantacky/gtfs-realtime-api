package main

import (
	"fmt"
	"log"
	"net/http"

	"connectrpc.com/grpcreflect"
	"github.com/kantacky/apis-go/research/gtfs_realtime/v1/gtfs_realtimev1connect"
	"github.com/kantacky/gtfs-realtime-api/gtfs_realtime_service"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
)

const port = "8080"

func main() {
	mux := http.NewServeMux()

	reflector := grpcreflect.NewStaticReflector(
		gtfs_realtimev1connect.GTFSRealtimeServiceName,
	)
	mux.Handle(grpcreflect.NewHandlerV1(reflector))

	gtfsRealtimeService := gtfs_realtime_service.New()

	gtfsRealtimeServicePath, gtfsRealtimeServiceHandler := gtfs_realtimev1connect.NewGTFSRealtimeServiceHandler(gtfsRealtimeService)
	mux.Handle(gtfsRealtimeServicePath, gtfsRealtimeServiceHandler)

	log.Printf("Serving on http://127.0.0.1:%s\n", port)

	http.ListenAndServe(
		fmt.Sprintf(":%s", port),
		h2c.NewHandler(mux, &http2.Server{}),
	)
}
