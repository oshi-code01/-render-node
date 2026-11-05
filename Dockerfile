# Route B: official xray binary copied into Alpine (official xray image has no shell)
FROM ghcr.io/xtls/xray-core:latest AS xray-src
FROM alpine:3.20
RUN apk add --no-cache ca-certificates tzdata
COPY --from=xray-src /usr/local/bin/xray /usr/local/bin/xray
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
