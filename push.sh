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

docker push "${DOCKER_REPO}:ruby-${RUBY_VERSION}-node-${NODE_VERSION}"
