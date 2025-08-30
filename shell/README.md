# Shell Scripting Practice

A comprehensive shell scripting development environment supporting multiple shells: Bash, Zsh, PowerShell, and more. Practice shell scripting concepts across different environments using VS Code devcontainers.

## 🚀 Quick Start

### Development Workflow

1. **Open in Dev Container**: Use Command Palette → "Dev Containers: Reopen in Container"
2. **Develop**: Write concepts in `concepts/` and tests in `tests/`
3. **Test**: `./scripts/build-and-test.sh`
4. **Test Shells**: `./scripts/test-shells.sh`

## 📁 Project Structure

```bash
bash/  (shell scripting practice)
├── .devcontainer/              # Development container config
│   ├── devcontainer.json      # VS Code devcontainer configuration
│   ├── docker-compose.yml     # Multi-environment setup
│   ├── Dockerfile             # Custom development image
│   └── setup.sh              # Post-create setup script
├── concepts/                   # Shell script implementations
│   ├── variables.sh           # Basic bash concepts
│   ├── zsh_features.zsh       # Zsh-specific features
│   └── powershell_basics.ps1  # PowerShell concepts
├── tests/                      # Test files
│   └── test_variables.sh      # Tests for bash variables
├── scripts/
│   ├── build-and-test.sh      # Build and test script
│   └── test-shells.sh         # Shell environment tester
└── README.md                  # This file
```

## � Supported Shells

- **Bash** - POSIX-compliant shell scripting
- **Zsh** - Advanced shell with powerful features
- **PowerShell** - Cross-platform object-oriented shell
- **Dash** - Lightweight POSIX shell
- **Fish** - User-friendly shell (available in container)

## �💻 Development Workflow

### 1. Open Development Environment

**Open in VS Code Dev Container:**
```bash
# In VS Code: Command Palette → "Dev Containers: Reopen in Container"
```

**Test Shell Environments:**
```bash
./scripts/test-shells.sh
```

### 2. Develop Shell Concepts

**Create New Concept:**

1. Add implementation: `concepts/new_concept.sh` (or .zsh, .ps1)
2. Add tests: `tests/test_new_concept.sh`
3. Make executable: `chmod +x concepts/new_concept.sh`

**Test During Development:**

```bash
./scripts/build-and-test.sh
```

**Test Specific Concept:**

```bash
./scripts/build-and-test.sh concept_name
```

### 3. Shell-Specific Development

**Bash/POSIX:**
- Focus on portability and POSIX compliance
- Use for system administration scripts

**Zsh:**
- Leverage advanced features like associative arrays
- Use powerful parameter expansions and globbing

**PowerShell:**
- Work with objects and .NET framework
- Cross-platform system management

### 4. Multi-Environment Testing

Use docker-compose to test in different environments:

```bash
# Test in Ubuntu environment
docker-compose -f .devcontainer/docker-compose.yml run ubuntu-env bash

# Test in Debian environment  
docker-compose -f .devcontainer/docker-compose.yml run debian-env bash
```

## 📝 Concept Guidelines

Each concept should:
- Be executable (`chmod +x`)
- Include a shebang (`#!/bin/bash`)
- Have functions that can be sourced and tested
- Include examples and demonstrations

## 🧪 Testing

- Tests use simple assertions and output verification
- Each test file should be executable
- Tests should source the concept file to test its functions

## 🛠️ Best Practices

- Use `set -e` for error handling
- Quote variables to prevent word splitting
- Use meaningful function and variable names
- Include comments for complex logic
- Follow consistent coding style
