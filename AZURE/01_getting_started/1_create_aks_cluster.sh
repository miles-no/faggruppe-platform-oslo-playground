#!/bin/bash
set -e pipefail

[[ -z "$RANDOM_ID" ]] && { echo "RANDOM_ID is empty" ; exit 1; }
[[ -z "$MY_RESOURCE_GROUP_NAME" ]] && { echo "MY_RESOURCE_GROUP_NAME is empty" ; exit 1; }
[[ -z "$REGION" ]] && { echo "REGION is empty" ; exit 1; }
[[ -z "$MY_AKS_CLUSTER_NAME" ]] && { echo "MY_AKS_CLUSTER_NAME is empty" ; exit 1; }
[[ -z "$MY_DNS_LABEL" ]] && { echo "MY_DNS_LABEL is empty" ; exit 1; }

echo "Creating AKS cluster $MY_AKS_CLUSTER_NAME in $MY_RESOURCE_GROUP_NAME ($REGION) [DNS: $MY_DNS_LABEL ]"

# create resource group

az group create --name $MY_RESOURCE_GROUP_NAME --location $REGION

# create aks cluster

az aks create --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_AKS_CLUSTER_NAME \
    --enable-managed-identity --node-count 1 \
    --generate-ssh-keys

# configure local kubectl config
az aks get-credentials --resource-group $MY_RESOURCE_GROUP_NAME --name $MY_AKS_CLUSTER_NAME