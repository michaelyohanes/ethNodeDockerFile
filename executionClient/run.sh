#!/bin/bash
function color() {
    # Usage: color "31;5" "string"
    # Some valid values for color:
    # - 5 blink, 1 strong, 4 underlined
    # - fg: 31 red,  32 green, 33 yellow, 34 blue, 35 purple, 36 cyan, 37 white
    # - bg: 40 black, 41 red, 44 blue, 45 purple
    printf '\033[%sm%s\033[0m\n' "$@"
}

color "33" "Copying data"
cp -rvf /var/lib/goethereum /var/lib/goethereum

cd "/app"
color "37;45" " Starting Geth execution client "

./geth \
--http \
--http.api web3,eth,net,engine,admin \
--ws --ws.port=8546 --ws.api=engine,eth,web3,net,debug \
--authrpc.jwtsecret=/tmp/jwt/jwt.hex \
--authrpc.port=8551 \
--authrpc.addr=0.0.0.0 --authrpc.vhosts=\* \
--datadir=/var/lib/goethereum