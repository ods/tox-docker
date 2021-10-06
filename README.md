# Docker container with tox and multiple versions of Python

Usage:

    docker run --rm -it \
        --mount type=bind,src=$(pwd),target=/src -w /src \
        --user $(id -u):$(id -g) \
        otkds/tox:3.10-3.7
