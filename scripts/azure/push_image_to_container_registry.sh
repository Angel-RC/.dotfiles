#!/usr/bin/env bash

set -euo pipefail

source "$DOTLY_PATH/scripts/core/_main.sh"
source "$DOTFILES_PATH/shell/functions.sh"

##?  Uso de upload_to_acr:
##?  
##?  upload_to_acr [IMAGEN] [TAG] [REGISTRO] [RUTA_DOCKERFILE]
##?  
##?  Parámetros:
##?    IMAGEN          - Nombre de la imagen (default: chatbot)
##?    TAG            - Tag de la imagen (default: latest-dev)
##?    REGISTRO       - Nombre del registro ACR (default: cralfredhubwesteurope)
##?    RUTA_DOCKERFILE - Ruta del contexto de Docker (default: .)
##?  
##?  Usage:
##?    upload_to_acr                                    # Usa todos los valores por defecto
##?    upload_to_acr myapp                             # Imagen: myapp, resto por defecto
##?    upload_to_acr myapp v1.0                        # Imagen: myapp, tag: v1.0
##?    upload_to_acr myapp v1.0 myregistry             # Personaliza imagen, tag y registro
##?    upload_to_acr myapp v1.0 myregistry ./backend   # Personaliza todo incluyendo ruta
docs::parse "$@"


function push_image_to_acr() {
    local image_name="${1:-chatbot}"
    local tag="${2:-latest-dev}"
    local registry_name="${3:-cralfredhubwesteurope}"
    local dockerfile_path="${4:-.}"
    
    echo "🚀 Iniciando proceso de subida a Azure Container Registry..."
    echo "📦 Imagen: $image_name:$tag"
    echo "🏷️  Registro: $registry_name.azurecr.io"
    echo "📁 Dockerfile: $dockerfile_path"
    echo ""

    
    # Construir la imagen
    echo "🔨 Construyendo imagen Docker..."
    if ! docker build -t "$image_name:$tag" "$dockerfile_path"; then
        echo "❌ Error al construir la imagen"
        return 1
    fi
    
    # Etiquetar para ACR
    local full_image_name="$registry_name.azurecr.io/$image_name:$tag"
    echo "🏷️  Etiquetando imagen para ACR..."
    if ! docker tag "$image_name:$tag" "$full_image_name"; then
        echo "❌ Error al etiquetar la imagen"
        return 1
    fi
    
    # Verificar autenticación con Azure
    if ! az account show >/dev/null 2>&1; then
        echo "⚠️  No estás autenticado con Azure. Iniciando login..."
        az login
    fi
    
    # Login al registro ACR
    if ! az acr login --name "$registry_name"; then
        echo "❌ Error al autenticar con ACR"
        return 1
    fi
    
    # Subir imagen
    echo "⬆️  Subiendo imagen a ACR..."
    if ! docker push "$full_image_name"; then
        echo "❌ Error al subir la imagen"
        return 1
    fi
    
    echo ""
    echo "🎉 ¡Imagen subida exitosamente!"
    echo "📍 Ubicación: $full_image_name"
}


push_image_to_acr