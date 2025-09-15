ARG IMAGE=scratch
ARG TAG=latest
FROM $IMAGE:$TAG AS base

# redeclare to use after FROM
ARG IMAGE
RUN echo $IMAGE
