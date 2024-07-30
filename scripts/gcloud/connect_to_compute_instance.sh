#!/usr/bin/env bash

set -euo pipefail

source "$DOTLY_PATH/scripts/core/_main.sh"

##? Connect to vm of gcloud
##?
##? Usage:
##?    connect
docs::parse "$@"

PROJECT_ID=$(gcloud projects list | fzf --header-lines=1 --prompt="Selecciona el proyecto: " | awk '{print $1}')
    
INSTANCE=$(gcloud --project=$PROJECT_ID compute instances list | fzf --header-lines=1 --prompt="Selecciona la maquina a la que te quieres conectar: ")
INSTANCE_NAME=$(echo $INSTANCE | awk '{print $1}')
INSTANCE_ZONE=$(echo $INSTANCE | awk '{print $2}')
gcloud beta compute ssh --project $PROJECT_ID --zone $INSTANCE_ZONE $INSTANCE_NAME 



