FROM golang:1.10.0 as builder

WORKDIR /go/src/github.com/ckbball/user-cli

COPY . .

RUN go get

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo .

FROM alpine:latest

RUN apk --no-cache add ca-certificates

RUN mkdir /app
WORKDIR /app
COPY --from=builder /go/src/github.com/ckbball/user-cli .

ENTRYPOINT ["./user-cli"]
CMD ["./user-cli"]