FROM ubuntu:20.04

LABEL maintainer="raackley@protonmail.com"

## Update apt-get and local packages
RUN apt-get update && apt-get -y dist-upgrade

## Install tools
RUN apt-get -y install unzip ansible

ADD https://releases.hashicorp.com/terraform/0.12.28/terraform_0.12.28_linux_amd64.zip /
RUN unzip /terraform_0.12.28_linux_amd64.zip -d /usr/bin/

## Cleanup
RUN apt-get -y autoremove
RUN rm /terraform_0.12.28_linux_amd64.zip