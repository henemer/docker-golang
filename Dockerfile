FROM golang:1.17.7 AS builder

WORKDIR /usr/src/app

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod ./
RUN go mod download && go mod verify

COPY . .

RUN go build -v -o /usr/src/app ./...

FROM scratch

COPY --from=builder /usr/src/app . 

CMD ["./app"]


