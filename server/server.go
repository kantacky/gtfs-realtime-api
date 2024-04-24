package server

func New() *gtfsRealtimeServiceServer {
	return &gtfsRealtimeServiceServer{}
}

type gtfsRealtimeServiceServer struct {
	UnimplementedGTFSRealtimeServiceServer
}
