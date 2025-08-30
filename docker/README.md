# Docker Practice

A bare bones Docker development environment for practicing Docker concepts including containers, images, networking, volumes, and multi-service applications.

## 🚀 Quick Start

### Development Workflow

1. **Develop**: Create Dockerfiles and docker-compose files in `concepts/`
2. **Test**: Use scripts in `tests/` to validate Docker setups
3. **Build & Test**: `./scripts/build-and-test.sh`

## 📁 Project Structure

```docker
docker/
├── concepts/                   # Docker implementations
│   ├── basic-container/       # Basic container example
│   ├── multi-stage/          # Multi-stage build example
│   └── compose-app/          # Docker Compose example
├── tests/                      # Test scripts
│   └── test_concepts.sh      # Tests for Docker concepts
├── scripts/
│   └── build-and-test.sh     # Build and test script
└── README.md                 # This file
```

## 💻 Development Workflow

### 1. Develop Docker Concepts

**Create New Concept:**

1. Add implementation: `concepts/new_concept/`
2. Add Dockerfile: `concepts/new_concept/Dockerfile`
3. Add docker-compose.yml (if needed)
4. Add tests: `tests/test_new_concept.sh`

**Test During Development:**

```bash
./scripts/build-and-test.sh
```

**Test Specific Concept:**

```bash
./scripts/build-and-test.sh concept_name
```

### 2. Example Usage

```bash
# Build and run a specific concept
cd concepts/basic-container
docker build -t practice-basic .
docker run practice-basic

# Run docker-compose examples
cd concepts/compose-app
docker compose up

# Run all tests
./scripts/build-and-test.sh
```

## 📝 Concept Guidelines

Each concept should:

- Have its own directory
- Include a clear Dockerfile
- Include a README.md explaining the concept
- Have corresponding tests
- Follow Docker best practices

## 🧪 Testing

- Tests validate that images build successfully
- Tests check that containers run as expected
- Tests verify networking and volume configurations
- Use `docker compose` for multi-service testing

## 🛠️ Best Practices

- Use multi-stage builds when appropriate
- Minimize image layers and size
- Use specific base image tags
- Implement proper health checks
- Follow security best practices
- Use .dockerignore files
- Document exposed ports and volumes
