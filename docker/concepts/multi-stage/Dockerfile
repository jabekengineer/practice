# Multi-stage build example
# This demonstrates how to use multi-stage builds to create smaller, more secure images

# Build stage
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY src/ ./src/

# Build the application
RUN npm run build

# Production stage
FROM alpine:3.19 AS production

# Install only runtime dependencies
RUN apk add --no-cache nodejs npm

# Create app user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S app -u 1001

WORKDIR /app

# Copy built application from build stage
COPY --from=builder --chown=app:nodejs /app/dist ./dist
COPY --from=builder --chown=app:nodejs /app/package*.json ./

# Install only production dependencies in the final stage
RUN npm install --omit=dev && npm cache clean --force

# Switch to non-root user
USER app

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD node dist/health.js || exit 1

# Start the application
CMD ["node", "dist/app.js"]
