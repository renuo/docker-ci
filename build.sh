#!/bin/bash

set -euo pipefail

if [ -z "${RUBY_VERSION:-}" ]; then
  echo "RUBY_VERSION is not set"
  exit 1
fi

if [ -z "${NODE_VERSION:-}" ]; then
  echo "NODE_VERSION is not set"
  exit 1
fi

docker build --build-arg RUBY_VERSION="$RUBY_VERSION" --build-arg NODE_VERSION="$NODE_VERSION" -t "${DOCKER_REPO}:ruby-${RUBY_VERSION}-node-${NODE_VERSION}" .
