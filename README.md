# Canvas LMS Docker image(s)

Canvas docker image (for science/development) with Postgresql database and Redis included.

    cd canvas-lms-node
    docker build -t canvas-lms-node .

    cd canvas-lms-ruby
    docker build -t canvas-lms-ruby .

    cd canvas-lms
    docker build -t orlissenberg/canvas-lms:latest .

    docker compose up

[Canvas - http://127.0.0.1:3000](http://127.0.0.1:3000)

[Canvas with SSL - https://127.0.0.1:8443](https://127.0.0.1:8443)

    Canvas Admin Username: docker@acme.edu
    Canvas Admin Password: canvas-docker

[Canvas GraphiQL - https://127.0.0.1:8443/graphiql](https://127.0.0.1:8443/graphiql)

Postgresql available at 127.0.0.1:5434

    Username: postgres
    No password.

Redis available at 127.0.0.1:6380

### Other useful commands:

    docker system prune
    docker run --rm -ti instructure/ruby-passenger:2.7 /bin/bash
    docker push orlissenberg/canvas-lms:latest

    docker run -v $(pwd)/shared:/shared --rm -ti orlissenberg/canvas-lms:latest /bin/bash
    docker compose run --rm canvas-docker /bin/bash

    # Create self-signed cert for HAProxy
    openssl req -nodes -x509 -newkey rsa:2048 -keyout test.key -out test.crt -days 1200
    cat test.key test.crt > ./test.pem

    pkill haproxy
    apt-get update && apt-get install net-tools

### Chrome Accept Self-signed Certificates

    chrome://flags/#allow-insecure-localhost

### Based on Dockerfile's from:

https://github.com/harvard-dce/canvas-docker and
https://github.com/instructure/canvas-lms
