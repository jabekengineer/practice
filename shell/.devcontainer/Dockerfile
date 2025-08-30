# Multi-shell development environment for shell scripting practice
FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install essential packages and shells
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        # Core utilities
        curl \
        wget \
        git \
        vim \
        nano \
        tree \
        htop \
        jq \
        # Shell utilities
        zsh \
        bash \
        dash \
        ksh \
        tcsh \
        fish \
        # Development tools
        shellcheck \
        bats \
        # PowerShell dependencies will be handled by feature
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install Oh My Zsh for the vscode user (will be done by feature, but ensuring it's available)
USER vscode

# Set up shell environments
RUN echo 'export PATH=$PATH:/workspace/scripts' >> ~/.bashrc \
    && echo 'export PATH=$PATH:/workspace/scripts' >> ~/.zshrc \
    && echo 'alias ll="ls -la"' >> ~/.bashrc \
    && echo 'alias ll="ls -la"' >> ~/.zshrc \
    && echo 'alias la="ls -la"' >> ~/.bashrc \
    && echo 'alias la="ls -la"' >> ~/.zshrc

# Create shell-specific configuration directories
RUN mkdir -p ~/.config/shell-practice

USER root
