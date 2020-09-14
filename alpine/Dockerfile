FROM openfaas/classic-watchdog:0.18.18 as watchdog


FROM golang:1.15.2-alpine3.12 as builder

COPY ./main.go gotest.go
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -tags osusergo,netgo \
	-ldflags '-w -extldflags "-static"' -o gotest gotest.go

FROM alpine:3.12
LABEL maintainer="ckatsak@cslab.ece.ntua.gr" version="v0.1.0-alpine3.12"

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog

# Add non root user
RUN addgroup -S app && adduser app -S -G app && \
	mkdir -vp /home/app && \
	chown app /home/app

WORKDIR /home/app
USER app

COPY --from=builder /go/gotest /home/app/gotest
ENV fprocess="/home/app/gotest"
ENV write_debug="true"
ENV combine_output="false"

EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

ENTRYPOINT ["fwatchdog"]
