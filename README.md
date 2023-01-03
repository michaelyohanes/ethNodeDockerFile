1. run `mkdir jwt`

2. Generate a jwt by running command below and move to `./jwt`

```openssl rand -hex 32 | tr -d "\n" > "./jwt/jwt.hex"```

3. run `docker network create ethereum` to create a network named ethereum

4. build prysm docker image `docker build -f consensusClient/dockerfile -t prysm-docker .`

5. build geth docker image `docker build -f executionClient/dockerfile -t geth-docker .`

6. type `bash` in terminal to use bash 
(optional step, as in mac zsh running the command below will have `zsh: no matches found: --authrpc.vhosts=*` wrr)

7. start execution client (geth) container by running
```
docker run -it -v $(pwd)/executionClient/data:/var/lib/goethereum -v $(pwd)/jwt:/tmp/jwt/jwtsecret -p 30303:30303/tcp -p 30303:30303/udp -p 8008:8008/tcp --network=ethereum --name execution-node ethereum/client-go:stable --http --http.api web3,eth,net,engine,admin --ws --ws.port=8546 --ws.api=engine,eth,web3,net,debug --authrpc.jwtsecret=/tmp/jwt/jwtsecret/jwt.hex --authrpc.addr=0.0.0.0 --authrpc.vhosts=* --datadir=/var/lib/goethereum --authrpc.port=8551
```

8. start consensus client (prysm) container by running
```
docker run -it -v $(pwd)/consensusClient/data:/var/lib/prysm -v $(pwd)/jwt:/tmp/jwt/jwtsecret -p 4000:4000 -p 13000:13000 -p 12000:12000/udp --network=ethereum --name beacon-node prysm-docker --execution-endpoint=http://execution-node:8551 --jwt-secret=/tmp/jwt/jwtsecret/jwt.hex --rpc-host=0.0.0.0 --monitoring-host=0.0.0.0 --checkpoint-sync-url=https://mainnet-checkpoint-sync.stakely.io --genesis-beacon-api-url=https://mainnet-checkpoint-sync.stakely.io --accept-terms-of-use --suggested-fee-recipient=0x65E9d8b6069eEc1Ef3b8bfaE57326008b7aec2c9 --datadir=/var/lib/prysm --rpc-port=4001 --monitoring-port=5054 
```