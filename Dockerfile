# This Dockerfile is designed for running the CI of Ruby on Rails projects
ARG RUBY_VERSION=3.4.12
FROM docker.io/library/ruby:$RUBY_VERSION

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y postgresql-client libjemalloc2  && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install Node.js and Yarn
ARG NODE_VERSION=24.22.3
ARG YARN_VERSION=1.22.22
ENV PATH=/usr/local/node/bin:$PATH
RUN ARCH=$(dpkg --print-architecture) && \
    case "${ARCH}" in amd64) ARCH=x64 ;; esac && \
    mkdir -p /usr/local/node && \
    curl -fsSL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-${ARCH}.tar.xz" | \
    tar -xJ -C /usr/local/node --strip-components=1 && \
    npm install -g yarn@$YARN_VERSION

ENV RAILS_ENV="test"

ARG INSTALL_BROWSER="false"
RUN if [ "$INSTALL_BROWSER" = "true" ]; then \
      apt-get update -qq && \
      apt-get install --no-install-recommends -y chromium chromium-driver  && \
      rm -rf /var/lib/apt/lists /var/cache/apt/archives; \
    fi
