# jfmercer/yarn is simply the latest node 7 image with yarn installed
FROM jfmercer/yarn:7.4.0

MAINTAINER John F. Mercer <john.f.mercer@gmail.com>

# Copy local files into image's /tmp directory
# The reason for two COPY instructions is to keep the node_modules
# in a separate layer from the application code. Only code changes to
# package.json will trigger this layer to rebuild; changes to ordinary
# application code won't affect it
# cf. http://stackoverflow.com/a/35774741/754842
COPY package.json yarn.lock /tmp/

# Install packages. Two RUN commands create two different layers,
# the first much more stable than the second
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | tee -a /etc/apt/sources.list; \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -; \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    libxpm4 \
    libxrender1 \
    libgtk2.0-0 \
    libnss3 \
    libgconf-2-4 \
    gtk2-engines-pixbuf \
    xfonts-cyrillic \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-base \
    xfonts-scalable \
    xvfb \
    google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

RUN cd /tmp && yarn install; \
    mkdir -p /opt/app && cd /opt/app && ln -s /tmp/node_modules

ENV DISPLAY :99
ENV CHROME_BIN /usr/bin/chromium

# Change directory so that our commands run inside this new directory
WORKDIR /opt/app
# COPY . /opt/app

COPY xvfb-setup.sh /usr/local/bin
RUN chmod a+x /usr/local/bin/xvfb-setup.sh
