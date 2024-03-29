ARG DEBIAN_VERSION=10
FROM debian:$DEBIAN_VERSION-slim as pyenv-base

ENV PYENV_ROOT=/pyenv
ENV PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN apt-get update -y \
    # PyEnv dependencies, taken from
    # https://github.com/pyenv/pyenv/wiki#suggested-build-environment
    # + git
    && apt-get install -y make build-essential git libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
        libffi-dev liblzma-dev \
    && rm -rf /var/lib/apt/lists/* \
    # install pyenv
    && curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash


FROM pyenv-base as pyenv
ARG PYTHON_VERSIONS="3.10.5 3.9.13 3.8.13"

RUN for pyver in $PYTHON_VERSIONS; do \
        pyenv install $pyver; \
    done \
    && pyenv global $PYTHON_VERSIONS

CMD ["python"]


FROM pyenv as tox

RUN pip install --no-cache-dir tox

CMD ["tox"]
