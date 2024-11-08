FROM golang:1.21 as base

WORKDIR /app

COPY go.mod .
RUN go mod download

COPY . .

RUN go build -o main .

#final stage - distroless image...
FROM gcr.io/distroless/base

COPY -from=base /app/main .

COPY --from=base /app/static ./static 
#static and binary content in ur distroless image

EXPOSE 8080
CMD [ "./main" ]
