# Lean PostgreSQL container for SQL practice and pgTAP testing
FROM postgres:16

# Install only essential tools for SQL development and testing
RUN apt-get update && apt-get install -y \
    postgresql-client \
    postgresql-contrib \
    postgresql-16-pgtap \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set working directory and copy source
WORKDIR /workspace

# Copy SQL files and scripts
COPY --chown=postgres:postgres concepts/ /workspace/concepts/
COPY --chown=postgres:postgres tests/ /workspace/tests/
COPY --chown=postgres:postgres scripts/ /workspace/scripts/
COPY --chown=postgres:postgres data/ /workspace/data/
COPY --chown=postgres:postgres *.md /workspace/

# Make scripts executable
RUN chmod +x /workspace/scripts/*.sh

USER postgres
WORKDIR /workspace
