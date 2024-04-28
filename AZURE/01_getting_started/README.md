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

## Cleaning up if you lost your shell

Since variables are stored in the current shell, if you lose the shell, it can be hard to clean up. We need 2 variables to clean up:

- MY_AKS_CLUSTER_NAME and
- MY_RESOURCE_GROUP_NAME

You can get these from the kubectl context created.

`MY_AKS_CLUSTER_NAME=$(kubectl config current-context)`

`MY_RESOURCE_GROUP_NAME=$(k config get-users | grep $MY_AKS_CLUSTER_NAME | sed -e 's/.*\_\(.*\)_.*/\1/')`
