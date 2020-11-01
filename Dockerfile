# base image
FROM python:3.8.3-slim-buster

# allow git hash env var to be set by cli
ARG GIT_HASH
ENV GIT_HASH=${GIT_HASH:-dev}

# specify base dir for all RUN, CMD, ENTRYPOINT, COPY, and ADD commands
WORKDIR /project

# copy current dir into work dir
COPY . .

# install dependencies in work dir
RUN pip install -r requirements.txt
