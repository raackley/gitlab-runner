FROM ubuntu:22.04

LABEL maintainer="raackley@protonmail.com"

## Install tools
RUN apt-get update && apt-get -y install unzip curl ansible flake8

## Install terraform
ENV TERRAFORM_VERSION 1.5.7
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip /
RUN unzip /terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin/ && \
    rm /terraform_${TERRAFORM_VERSION}_linux_amd64.zip

## Install kubectl
ENV KUBECTL_VERSION v1.28.4
ADD https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/
RUN chmod +x /usr/local/bin/kubectl

## Install Helm
ADD https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 /get_helm.sh
RUN chmod 700 /get_helm.sh && \
    /get_helm.sh && \
    rm /get_helm.sh
