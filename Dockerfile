# First Level

FROM golang:1.19-alpine AS builder

WORKDIR /app

COPY go.* ./

RUN go mod download

COPY . .

RUN GOOS="linux" go build .

# Second Level

FROM alpine

COPY --from=builder app/altschool-sms .
COPY --from=builder app/log.json .
COPY --from=builder app/config.env .

CMD ["./altschool-sms"]