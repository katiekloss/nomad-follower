FROM golang:1.25-alpine AS build

WORKDIR /app
ADD go.* .
ADD *.go .
RUN go build

FROM alpine:latest

RUN mkdir /log && chown 1000:1000 /log

USER 1000

COPY --from=build /app/nomad-follower .

WORKDIR /log

ENTRYPOINT ["/nomad-follower"]
