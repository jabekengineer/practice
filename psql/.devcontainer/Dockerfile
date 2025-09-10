ARG TAG=17
FROM postgres:${TAG} as base

RUN apt-get update && apt-get install -y postgresql-17-pgtap \
    make tree

USER postgres