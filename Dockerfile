FROM ubuntu:20.04

LABEL maintainer="raackley@protonmail.com"

## Update apt-get and local packages
RUN apt-get update && apt-get -y dist-upgrade

## Install tools
RUN apt-get -y install ansible