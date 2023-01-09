1. run `mkdir jwt`

2. Generate a jwt by running command below and move to `./jwt`

    ```
    openssl rand -hex 32 | tr -d "\n" > "./jwt/jwt.hex"
    ```

3. run `docker network create ethereum` to create a network named ethereum

4. build beacon-node image `docker build --platform linux/amd64 -f consensusClient/dockerfile -t beacon-node .`

5. run beacon-node `docker run --platform linux/amd64 -d --network=ethereum -v $(pwd)/consensusClient/data:/var/lib/prysm --name beacon-node  -it beacon-node`

6. build execution-node image `docker build -f executionClient/dockerfile -t execution-node .`

7. run execution-node `docker run -d --network=ethereum -v $(pwd)/executionClient/data:/var/lib/goethereum --name execution-node -it execution-node`
