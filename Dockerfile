FROM ubuntu:20.04

LABEL maintainer="raackley@protonmail.com"

## Update apt-get and local packages
RUN apt-get update && apt-get -y dist-upgrade

## Install tools
RUN apt-get -y install unzip curl ansible

## Install terraform
ADD https://releases.hashicorp.com/terraform/0.12.28/terraform_0.12.28_linux_amd64.zip /
RUN unzip /terraform_0.12.28_linux_amd64.zip -d /usr/bin/

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
RUN rm /terraform_0.12.28_linux_amd64.zip
RUN rm /get_helm.sh