# .devcontainer/Dockerfile
FROM node:22-bookworm

# 1. Install OS deps you want available in dev for everyone
RUN apt-get update && apt-get install -y \
    curl \
    git \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# 2. Set a canonical workspace path (must match workspaceFolder in devcontainer.json)
WORKDIR /workspaces/css_html

# 3. Make sure the 'node' user (which already exists in this base image)
#    owns the workspace directory
USER root
RUN chown -R node:node /workspaces/css_html
USER node

# 4. Copy only package manifests first for layer caching
COPY --chown=node:node package.json package-lock.json ./

# 5. Switch to non-root before running npm so node_modules ends up owned by 'node'
RUN npm install

# 6. Install Playwright browsers (and their system deps) into the image
USER root
ENV PLAYWRIGHT_BROWSERS_PATH=/opt/playwright
RUN npx playwright install --with-deps
RUN chown -R node:node /opt/playwright
USER node

# 7. Copy the rest of the source tree
#    We need root to copy files from the build context, then fix perms.
USER root
COPY . .
RUN chown -R node:node /workspaces/css_html

# 8. Drop back to non-root for the dev container runtime
USER node

# 9. Default command for interactive dev sessions
CMD ["bash"]
