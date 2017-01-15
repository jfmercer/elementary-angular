# jfmercer/yarn is simply the latest node 7 image with yarn installed
FROM jfmercer/yarn:latest

MAINTAINER John F. Mercer <john.f.mercer@gmail.com>

# Change directory so that our commands run inside this new directory
WORKDIR /opt/app

# Copy local files into image's /tmp directory
ADD package.json yarn.lock /tmp/

# Copy cache contents (if any) from local machine
# IMPORTANT: ADD has some weird baked-in tar magic & isn't used here
# Cf. https://www.ctl.io/developers/blog/post/dockerfile-add-vs-copy/
# COPY .yarn-cache.tgz /

# Install packages
# RUN yarn cache clean; \
    # This will overwrite existing files by default
    # tar -xzf /.yarn-cache.tgz --directory /root/.cache/yarn; \
RUN cd /tmp && yarn install --pure-lockfile; \
    mkdir -p /opt/app && cd /opt/app && ln -s /tmp/node_modules

# Copy the code
ADD . /opt/app

# Expose the port the app runs in
EXPOSE 4200

# Serve the app
# CMD ["npm", "start"]
