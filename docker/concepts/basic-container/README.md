# Basic Container Example

This example demonstrates fundamental Docker concepts including:

- Creating a simple Dockerfile
- Using a lightweight base image (Alpine Linux)
- Installing packages in a container
- Copying files into the image
- Setting permissions
- Exposing ports
- Adding health checks
- Running a simple application

## Building the Image

```bash
docker build -t practice-basic .
```

## Running the Container

```bash
# Run in foreground
docker run --rm -p 8080:8080 practice-basic

# Run in background
docker run -d --name basic-app -p 8080:8080 practice-basic

# View logs
docker logs basic-app

# Stop the container
docker stop basic-app
```

## Testing

```bash
# Check if container is running
docker ps

# Test the application
curl http://localhost:8080

# Check health status
docker inspect --format='{{.State.Health.Status}}' basic-app
```

## Key Docker Concepts Demonstrated

1. **Base Images**: Using Alpine Linux for small footprint
2. **Layers**: Each instruction creates a new layer
3. **WORKDIR**: Setting the working directory
4. **COPY**: Adding files to the image
5. **RUN**: Executing commands during build
6. **EXPOSE**: Documenting which ports the container uses
7. **HEALTHCHECK**: Monitoring container health
8. **CMD**: Default command to run when container starts
