package main

import (
	"fmt"
	"log"
	"net"

	"github.com/kantacky/gtfs-realtime-api/server"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

func main() {
	port := 8080
	listener, err := net.Listen("tcp", fmt.Sprintf(":%d", port))
	if err != nil {
		panic(err)
	}

	s := grpc.NewServer()
	server.RegisterGTFSRealtimeServiceServer(s, server.New())

	reflection.Register(s)

	log.Printf("start gRPC server port: %v", port)
	s.Serve(listener)
}
