# syntax=docker/dockerfile:1.1.7-experimental
FROM skynet-common:py3.7-1.2.3

WORKDIR /keras-resnet

COPY ./requirements.txt .
RUN --mount=type=cache,target=/root/.cache/pip,id=cache-pip \
    pip install -r requirements.txt

COPY ./keras_resnet ./keras_resnet
COPY ./tests ./tests

CMD ["pytest", "-s", "-v", "./tests"]
