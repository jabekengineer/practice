# syntax=docker/dockerfile:1
# escape=`
# check=skip=all;error=false
ARG BASEIMAGE=alpine:3
# comment
FROM $BASEIMAGE

RUN echo "this `
    is `
    an `
    appropriately `
    escaped `
    sequence"
