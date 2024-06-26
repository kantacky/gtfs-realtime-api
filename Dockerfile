FROM golang:1.22.2
ENV TZ 'Asia/Tokyo'
RUN mkdir /app
WORKDIR /app
COPY . .
RUN go mod tidy
RUN go build ./main.go
ENTRYPOINT [ "/app/main" ]
