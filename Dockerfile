FROM golang:1.25-alpine AS build

WORKDIR /app
ADD *.go .
ADD go.* .

RUN go build

FROM alpine:latest
COPY --from=build /app/nomad-follower .

USER 1000
CMD nomad-follower