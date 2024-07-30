#!/usr/bin/env bash

set -euo pipefail

source "$DOTLY_PATH/scripts/core/_main.sh"
source "$DOTFILES_PATH/shell/functions.sh"

##? Resize cluster of Kubernetes. 
##? Adjust the number of nodes max and min for each node pool
##? Usage:
##?    resize_cluster_kubernetes
docs::parse "$@"

# Select the cluster to resize
PROJECT_ID=$(gcloud projects list | fzf --header-lines=1 --prompt="Selecciona el proyecto: " | awk '{print $1}')
CLUSTER=$(gcloud container clusters list --project=$PROJECT_ID | fzf --header-lines=1 --prompt="Selecciona el cluster: ")
CLUSTER_NAME=$(echo $CLUSTER | awk '{print $1}')
CLUSTER_REGION=$(echo $CLUSTER | awk '{print $2}')

# List the node pools to resize
NODES_SIZES=(`echo "$(gcloud container node-pools list \
    --cluster $CLUSTER_NAME \
    --region $CLUSTER_REGION \
    --project=$PROJECT_ID \
    --sort-by=~MACHINE_TYPE | awk 'NR>1 {print $1}')" \
    `)

for SIZE in "${NODES_SIZES[@]}"; do

        read_number "Minimo de nodos ($SIZE): " TOTAL_MIN_NODES
        read_number "Maximo de nodos ($SIZE): " TOTAL_MAX_NODES

        gcloud container clusters update $CLUSTER_NAME \
            --project=$PROJECT_ID \
            --node-pool=$SIZE \
            --region $CLUSTER_REGION \
            --enable-autoscaling \
            --total-min-nodes=$TOTAL_MIN_NODES \
            --total-max-nodes=$TOTAL_MAX_NODES 

        information "Cluster $CLUSTER_NAME - Nodos ($SIZE): Autoescalado entre $TOTAL_MIN_NODES y $TOTAL_MAX_NODES nodos."   

done