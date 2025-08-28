# syntax=docker/dockerfile:1.7
FROM node:24-alpine AS base
ENV NODE_ENV=production

# ---- dev stage ----
FROM base AS dev
ENV NODE_ENV=development
RUN apk add --no-cache git curl bash
WORKDIR /workspace

# Install global packages that might be useful
RUN npm install -g npm@latest

# Health check that doesn't depend on the app
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD node --version || exit 1

CMD ["/bin/bash"]

# ---- runtime stage ----
FROM base AS runtime
WORKDIR /app
COPY package*.json ./
RUN apk add --no-cache nodejs npm && \
    npm ci --only=production && \
    npm run build && \
    rm -rf node_modules

FROM nginx:alpine AS final
COPY --from=runtime /app/dist /usr/share/nginx/html
COPY nginx.default.conf /etc/nginx/conf.d/default.conf

# Create non-root user
RUN addgroup -g 1001 -S runner && \
    adduser -S runner -u 1001 && \
    chown -R runner:runner /usr/share/nginx/html
USER runner

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:80 || exit 1

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]