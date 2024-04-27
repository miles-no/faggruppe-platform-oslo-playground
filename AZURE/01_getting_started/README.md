# Simple AKS getting started

## Creating

From a shell

- Ensure you have a valid connection to Azure:

`az login`

- Verify you're using the Azure subscription:

`az account show`

- Set up some global variables:

`source ./0_prereqs`

- Create the AKS cluster and kubectl config:

`./1_create_aks_cluster.sh`

- Connect to the cluster:

`k9s` or `k9s --context $MY_AKS_CLUSTER_NAME`

## Cleaning up

- Delete the AKS cluster and kubectl config:

`./3_delete_aks_cluster.sh`

- Remove global variables:

`source ./99_cleanup`
