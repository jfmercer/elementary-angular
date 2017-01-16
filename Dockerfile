# jfmercer/yarn is simply the latest node 7 image with yarn installed
FROM jfmercer/yarn:latest

MAINTAINER John F. Mercer <john.f.mercer@gmail.com>

# Copy local files into image's /tmp directory
# The reason for two COPY instructions is to keep the node_modules
# in a separate layer from the application code. Only code changes to
# package.json will trigger this layer to rebuild; changes to ordinary
# application code won't affect it
# cf. http://stackoverflow.com/a/35774741/754842
COPY package.json yarn.lock /tmp/

# Install packages
RUN cd /tmp && yarn install; \
    mkdir -p /opt/app && cd /opt/app && ln -s /tmp/node_modules

# Change directory so that our commands run inside this new directory
WORKDIR /opt/app
COPY . /opt/app
