FROM openfaas/classic-watchdog:0.18.18 as watchdog


FROM golang:1.15.2-buster as builder

COPY ./main.go gotest.go
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -tags osusergo,netgo \
	-ldflags '-w -extldflags "-static"' -o gotest gotest.go && \
	strip gotest


FROM scratch
LABEL maintainer="ckatsak@cslab.ece.ntua.gr" version="v0.1.0-scratch"

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
COPY --from=builder /go/gotest /gotest

ENV fprocess="/gotest"
ENV write_debug="true"
ENV combine_output="false"
ENV suppress_lock="true"

EXPOSE 8080
#HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1
###  ^  This shouldn't work... right?

ENTRYPOINT ["fwatchdog"]
