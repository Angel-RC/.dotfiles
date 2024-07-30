#!/usr/bin/env bash

set -euo pipefail

source "$DOTLY_PATH/scripts/core/_main.sh"

##? Connect to kubernetes cluster of gcloud
##?
##? Usage:
##?    connect
docs::parse "$@"

PROJECT_ID=$(gcloud projects list | fzf --header-lines=1 --prompt="Selecciona el proyecto: " | awk '{print $1}')

CLUSTER=$(gcloud container clusters list --project=$PROJECT_ID | fzf --header-lines=1 --prompt="Selecciona el cluster a la que te quieres conectar: ")
CLUSTER_NAME=$(echo $CLUSTER | awk '{print $1}')
CLUSTER_ZONE=$(echo $CLUSTER | awk '{print $2}')
gcloud container clusters get-credentials $CLUSTER_NAME --zone $CLUSTER_ZONE --project $PROJECT_ID



