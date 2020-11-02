# base image
FROM python:3.8.3-slim-buster

# allow git hash env var to be set by cli
ARG GIT_HASH
ENV GIT_HASH=${GIT_HASH:-dev}
ENV TINI_VERSION="v0.19.0"

# add tini for better signal forwarding and zombie process cleanup
ADD https://github.com/krallin/tini/releases/downloads/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# standard styling for list args
RUN pip install -U \
    pip \
    setuptools \
    wheel

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

# prepend to startup command, so in this case "/tini -- python app.py"
ENTRYPOINT ["/tini", "--"]