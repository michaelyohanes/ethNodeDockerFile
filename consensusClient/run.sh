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
cp -rvf /var/lib/prysm /var/lib/prysm

cd "app/cmd/beacon-chain"
color "37;45" " Starting Beacon Chain consensus client"

./beacon-chain \
--accept-terms-of-use \
# --checkpoint-sync-url="https://mainnet-checkpoint-sync.stakely.io" \
# --genesis-beacon-api-url="https://mainnet-checkpoint-sync.stakely.io" \
--jwt-secret=/tmp/jwt/jwt.hex \
--rpc-host=0.0.0.0 \
--monitoring-host=0.0.0.0 \
--suggested-fee-recipient=0x65E9d8b6069eEc1Ef3b8bfaE57326008b7aec2c9 \
--datadir=/var/lib/prysm \
--rpc-port=4001 \
--monitoring-port=5054