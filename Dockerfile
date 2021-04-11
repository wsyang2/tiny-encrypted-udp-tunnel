FROM alpine as intermediate
LABEL stage=intermediate

RUN apk update && \
    apk add --update build-base

COPY . /udpfwd
WORKDIR /udpfwd
RUN make


FROM alpine
COPY --from=intermediate /udpfwd/forward /bin
RUN chmod +x /bin/forward
ENTRYPOINT ["/bin/forward"]
