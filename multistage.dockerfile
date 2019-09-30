FROM golang:latest as builder
LABEL maintainer="Rajeev Singh <rajeevhub@gmail.com>"
WORKDIR /app
COPY . .
RUN CGO_ENABLED=O GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/main .
EXPOSE 8080
CMD ["./main"]
