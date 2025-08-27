FROM node:24-alpine AS base
ENV NODE_ENV=development
WORKDIR /workspace

# -- dev stage --
FROM base AS dev
RUN apk update && apk add --no-cache git ca-certificates
COPY package*.json ./
RUN npm ci
COPY . .
CMD ["/bin/bash", "-c", "echo hello"]

# -- runtime stage --
FROM node:24-alpine AS runtime
ENV NODE_ENV=production
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev
COPY . .
ENTRYPOINT ["node", "scripts/run-concept.js"]