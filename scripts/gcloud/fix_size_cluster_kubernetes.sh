#!/usr/bin/env bash

set -euo pipefail

source "$DOTLY_PATH/scripts/core/_main.sh"
source "$DOTFILES_PATH/shell/functions.sh"

##? Fixed size of cluster. 
##? Adjust the number of nodes for each node pool in a cluster.
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

    ZONES=$(gcloud compute zones list --filter="region~'$CLUSTER_REGION'" | awk '{print $1}' | fzf --multi --header-lines=1 --prompt="Que zonas quieres usar para los nodos $SIZE: ")
    ZONES=$(echo $ZONES | tr ' ' ',')
    read_number "Numero de nodos $SIZE (por zona): " NUM_NODES

    gcloud container node-pools update $SIZE --cluster=$CLUSTER_NAME --region=$CLUSTER_REGION --enable-autoscaling
    gcloud container node-pools update $SIZE \
        --project $PROJECT_ID \
        --cluster $CLUSTER_NAME \
        --region $CLUSTER_REGION \
        --node-locations $ZONES

    gcloud container clusters resize $CLUSTER_NAME \
        --project $PROJECT_ID \
        --region $CLUSTER_REGION \
        --node-pool $SIZE \
        --num-nodes $NUM_NODES    
done