# This Dockerfile is designed for running the CI of Ruby on Rails projects
ARG RUBY_VERSION=3.4.7
FROM docker.io/library/ruby:$RUBY_VERSION

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y postgresql-client libjemalloc2  && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install yarn and node
ARG NODE_VERSION=22.21.1
ARG YARN_VERSION=1.22.22
ENV PATH=/usr/local/node/bin:$PATH
RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node && \
    npm install -g yarn@$YARN_VERSION && \
    rm -rf /tmp/node-build-master

ENV RAILS_ENV="test"

ARG INSTALL_BROWSER="false"
RUN if [ "$INSTALL_BROWSER" = "true" ]; then \
      apt-get update -qq && \
      apt-get install --no-install-recommends -y chromium chromium-driver  && \
      rm -rf /var/lib/apt/lists /var/cache/apt/archives; \
    fi
