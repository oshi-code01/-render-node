#!/bin/sh
set -e
: "${UUID:?UUID env required}"
WS_PATH="${WS_PATH:-/ray}"
PORT="${PORT:-10000}"
cat > /config.json <<JSON
{
  "log": { "loglevel": "warning" },
  "inbounds": [
    {
      "listen": "0.0.0.0",
      "port": ${PORT},
      "protocol": "vless",
      "settings": {
        "clients": [ { "id": "${UUID}", "level": 0 } ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": { "path": "${WS_PATH}" }
      }
    }
  ],
  "outbounds": [
    { "protocol": "freedom", "settings": { "domainStrategy": "UseIP" } }
  ]
}
JSON
exec /usr/local/bin/xray run -config /config.json
