# Stage 1: Build static binary
FROM alpine:3.20 as builder

RUN apk add --no-cache gcc musl-dev

COPY hellocontainer.c .
RUN gcc -static -O2 -o hellocontainer hellocontainer.c

# Stage 2: Minimal runtime container
FROM scratch

COPY --from=builder /hellocontainer /hellocontainer

# Use a volume to persist logs
VOLUME ["/data"]

CMD ["/hellocontainer"]
