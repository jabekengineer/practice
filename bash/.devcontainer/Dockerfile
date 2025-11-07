FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Minimal locale + tooling
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      bash curl git make ca-certificates \
      shellcheck shfmt bats \
      python3 \
      ruby ruby-dev && \
    gem install bashcov && \
    git clone https://github.com/bats-core/bats-assert.git /usr/lib/bats-assert && \
    rm -rf /var/lib/apt/lists/*

# Default to bash
SHELL ["/bin/bash", "-lc"]
