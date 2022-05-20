# Canvas LMS Docker image(s)

Canvas docker image (for science) with Postgresql database and Redis included.

    cd canvas-lms-node
    docker build -t canvas-lms-node .

    cd canvas-lms-ruby
    docker build -t canvas-lms-ruby .
    
    cd canvas-lms
    docker build -t orlissenberg/canvas-lms:latest .

    docker compose up

Other useful commands:

    docker system prune
    docker run --rm -ti instructure/ruby-passenger:2.7 /bin/bash
    docker push orlissenberg/canvas-lms:latest
    docker run --rm -ti orlissenberg/canvas-lms:latest /bin/bash

Based on Dockerfile's from:

https://github.com/harvard-dce/canvas-docker and
https://github.com/instructure/canvas-lms
