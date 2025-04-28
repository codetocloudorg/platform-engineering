FROM mcr.microsoft.com/devcontainers/python:1-3.12-bullseye
ENV PYTHONUNBUFFERED 1
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends postgresql-client