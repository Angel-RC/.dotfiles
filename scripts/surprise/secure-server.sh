#!/usr/bin/env bash

set -euo pipefail

source "$DOTLY_PATH/scripts/core/_main.sh"

##? Secure server
##?
##? Usage:
##?    hello
docs::parse "$@"

sudo useradd "$USER" -G sudo
# En el fichero /etc/ssh/sshd_config añadir: AllowUsers "$USER"
