# syntax=docker/dockerfile:1.7
FROM python:3.12-slim AS base
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1

# ---- dev stage ----
FROM base AS dev
RUN apt-get update && apt-get install -y --no-install-recommends \
      git build-essential curl && rm -rf /var/lib/apt/lists/*
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD python -c "print('ok')"
WORKDIR /workspace
COPY pyproject.toml ./
RUN pip install -e .[dev]
COPY . .
RUN useradd -ms /bin/bash jabekengineer
CMD ["/bin/bash", "-c", "echo hello"]

# ---- runtime stage ----
FROM base AS runtime
RUN useradd -ms /bin/bash jabekengineer
WORKDIR /workspace
COPY pyproject.toml ./
RUN pip install -e .       # only runtime deps (no [dev])
COPY . .
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD python -c "print('pyhello')"

# Entrypoint logic: list concepts and select
ARG concept
ENV PYTHONPATH=/workspace
ENTRYPOINT ["bash", "-c", "\
if [ -z \"$concept\" ]; then \
      echo 'Available concepts:'; \
      ls concepts | grep .py$ | sed 's/.py$//'; \
      read -p 'Enter concept name: ' concept; \
fi; \
if [ ! -f concepts/${concept}.py ]; then \
      echo "Concept $concept not found."; exit 1; \
fi; \
python concepts/${concept}.py --nums \"$nums\"\"]