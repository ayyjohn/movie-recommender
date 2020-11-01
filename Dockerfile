# base image
FROM python:3.8.3-slim-buster

# allow git hash env var to be set by cli
ARG GIT_HASH
ENV GIT_HASH=${GIT_HASH:-dev}

# specify base dir for all RUN, CMD, ENTRYPOINT, COPY, and ADD commands
WORKDIR /project

# create a new user so I'm not running as root
RUN useradd -m -r user && chown user /project

# copy requirements and install dependencies first so that they're cached
COPY requirements.txt ./
RUN pip install -r requirements.txt

# copy current dir into work dir
COPY . .

USER user