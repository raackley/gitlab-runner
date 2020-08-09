FROM ubuntu:20.04

LABEL maintainer="raackley@protonmail.com"

## Update apt-get and local packages
RUN apt-get update && apt-get -y dist-upgrade

## Install tools
RUN apt-get -y install unzip curl ansible

## Install terraform
ENV TERRAFORM_VERSION 0.12.29
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip /
RUN unzip /terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin/

## Install kubectl
ENV KUBECTL_VERSION v1.18.6
ADD https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/
RUN chmod +x /usr/local/bin/kubectl

## Install Helm
ADD https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 /get_helm.sh
RUN chmod 700 /get_helm.sh
RUN /get_helm.sh

## Cleanup
RUN apt-get -y autoremove
RUN apt-get clean
RUN apt-get autoclean
RUN rm /terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN rm /get_helm.sh