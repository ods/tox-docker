ARG ALPINE_VERSION=3.13
FROM alpine:$ALPINE_VERSION as pyenv-base

ENV PYENV_ROOT=/pyenv
ENV PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN apk add --no-cache \
    curl \
    # PyEnv deps
    git bash build-base libffi-dev openssl-dev bzip2-dev zlib-dev readline-dev sqlite-dev \
    # install pyenv
    && curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

SHELL ["/bin/bash", "-c"]
CMD ["/bin/bash"]


FROM pyenv-base as pyenv
ARG PYTHON_VERSIONS="3.9.1 3.8.7 3.7.9 3.6.12"

RUN for pyver in $PYTHON_VERSIONS; do pyenv install $pyver; done \
    && pyenv global $PYTHON_VERSIONS

CMD ["python"]


FROM pyenv as tox

RUN pip install tox

CMD ["tox"]
