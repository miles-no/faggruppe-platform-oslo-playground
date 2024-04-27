# Simple AKS getting started

## Creating

From a shell

- Ensure you have a valid connection to Azure:

`az login`

- Verify you're using the Azure subscription:

`az account show`

- Set up some global variables:

`source ./0_prereqs`

- Create the AKS cluster

`./1_create_aks_cluster.sh`

## Cleaning up

- Delete the AKS cluster and kubectl config:

`./9_delete_aks_cluster.sh`

- Remove global variables:

`source ./99_cleanup`
