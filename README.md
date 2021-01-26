# Docker container with tox and multiple versions of Python

Usage:

    docker run --rm -it --mount type=bind,src=$(pwd),target=/src -w /src --user $(id -u):$(id -g) otkds/tox

For complex cases define custom Dockefile based on it like the following:

    FROM otkds/tox:3.9.1-3.6.12

    RUN apk add --no-cache \
        # Updates `timeout` command for `wait-for-it.sh`
        coreutils \
        # Needed for psycopg2
        postgresql-dev

    # For reports
    RUN pip install coverage

    RUN mkdir -p /src
    WORKDIR /src

    CMD ["tox"]
