# Canvas LMS Docker

    cd canvas-lms-node
    docker build -t canvas-lms-node .

    cd canvas-lms-ruby
    docker build -t canvas-lms-ruby .
    
    docker build --no-cache -t canvas-lms .
    docker run --rm -ti canvas-lms /bin/bash

    docker compose up

Other useful commands:

    docker system prune
    docker run --rm -ti instructure/ruby-passenger:2.7 /bin/bash

Based on Dockerfile's from:

https://github.com/harvard-dce/canvas-docker and
https://github.com/instructure/canvas-lms
