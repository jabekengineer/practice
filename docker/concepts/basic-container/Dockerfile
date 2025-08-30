# Use a lightweight base image
FROM alpine:3.19

# Set working directory
WORKDIR /app

# Install basic tools
RUN apk add --no-cache curl

# Copy application files
COPY app.sh .

# Make script executable
RUN chmod +x app.sh

# Expose port (example)
EXPOSE 8080

# Add health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/health || exit 1

# Run the application
CMD ["./app.sh"]
