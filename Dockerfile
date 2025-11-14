FROM golang:1.25 AS builder

WORKDIR /app
COPY go.mod ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o goserver main.go

FROM debian:stable-slim
COPY --from=builder /app/goserver /bin/goserver

ENV PORT=8991
CMD ["/bin/goserver"]
