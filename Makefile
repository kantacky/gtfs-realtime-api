.PHONY: install proto protoc-swift

install:
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	go get -u
	go mod tidy

proto:
	protoc ./proto/gtfs-realtime-api.proto \
		--proto_path=./proto \
		--go_out=./server \
		--go_opt=paths=source_relative \
		--go-grpc_out=./server \
		--go-grpc_opt=paths=source_relative

protoc-swift:
	protoc proto/gtfs-realtime-api.proto \
		--proto_path=./proto \
		--plugin=$(HOMEBREW_PREFIX)/bin/protoc-gen-swift \
		--swift_out=./generated \
		--plugin=$(HOMEBREW_PREFIX)/bin/protoc-gen-grpc-swift \
		--grpc-swift_out=./generated
