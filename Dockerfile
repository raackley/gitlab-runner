FROM ubuntu:20.04

LABEL maintainer="raackley@protonmail.com"

## Update apt-get and local packages
RUN apt-get update && apt-get -y dist-upgrade

## Install tools
RUN apt-get -y install unzip curl ansible

## Install terraform
ENV TERRAFORM_VERSION 0.13.5
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip /
RUN unzip /terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin/

## Install kubectl
ENV KUBECTL_VERSION v1.19.4
ADD https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/
RUN chmod +x /usr/local/bin/kubectl

## Install Helm
ADD https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 /get_helm.sh
RUN chmod 700 /get_helm.sh && /get_helm.sh

## Cleanup
RUN apt-get -y autoremove && \
    apt-get clean && \
    apt-get autoclean && \
    rm /terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm /get_helm.sh
