#!/bin/bash
set -e pipefail

[[ -z $MY_RESOURCE_GROUP_NAME ]] && { echo "MY_RESOURCE_GROUP_NAME is empty" ; exit 1; }
[[ -z $MY_AKS_CLUSTER_NAME ]] && { echo "MY_AKS_CLUSTER_NAME is empty" ; exit 1; }

# remove local kubectl config
kubectl config delete-cluster $MY_AKS_CLUSTER_NAME
kubectl config delete-context $MY_AKS_CLUSTER_NAME

# delete Azure resource group 
az group delete --name $MY_RESOURCE_GROUP_NAME --no-wait

# reminder on variables
echo "Remember to clean up your variables by running: 'source ./99_cleanup'"
