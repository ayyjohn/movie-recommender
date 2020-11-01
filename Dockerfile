# base image
FROM python:3.8.3-slim-buster

# allow git hash env var to be set by cli
ARG GIT_HASH
ENV GIT_HASH=${GIT_HASH:-dev}

# copy current dir into /src
COPY . /src

# install dependencies in /src
RUN pip install -r /src/requirements.txt
