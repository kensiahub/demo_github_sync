#!/bin/bash
# sync.sh - Script de sincronización con GitHub usando Pull Requests
# Uso: ./sync.sh "mensaje de commit"
#      ./sync.sh (usa mensaje por defecto)

set -e

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Mensaje de commit (parámetro o por defecto)
COMMIT_MSG="${1:-Actualización desde DeepAgent $(date '+%Y-%m-%d %H:%M')}"

echo -e "${BLUE}🔄 Iniciando sincronización con GitHub (flujo PR)...${NC}\n"

# Verificar que estamos en el directorio correcto
if [ ! -d ".git" ]; then
    echo -e "${RED}❌ Error: No estás en un repositorio Git${NC}"
    exit 1
fi

# Asegurarse de estar en main y actualizado
echo -e "${YELLOW}📥 Actualizando rama main...${NC}"
git checkout main 2>/dev/null || {
    echo -e "${RED}❌ Error: No se pudo cambiar a la rama main${NC}"
    exit 1
}
git pull origin main || {
    echo -e "${YELLOW}⚠️  Advertencia: No se pudo actualizar main (continuando...)${NC}"
}

# Crear nombre de branch único con timestamp
TIMESTAMP=$(date '+%Y%m%d-%H%M%S')
BRANCH_NAME="deepagent/sync-${TIMESTAMP}"

echo -e "\n${GREEN}🌿 Creando branch: ${BRANCH_NAME}${NC}"
git checkout -b "$BRANCH_NAME" || {
    echo -e "${RED}❌ Error: No se pudo crear el branch${NC}"
    exit 1
}

# Agregar todos los cambios
echo -e "${YELLOW}📝 Agregando cambios...${NC}"
git add .

# Verificar si hay cambios para commitear
if git diff --cached --quiet; then
    echo -e "${GREEN}✅ No hay cambios para sincronizar${NC}"
    git checkout main
    git branch -D "$BRANCH_NAME"
    exit 0
fi

# Mostrar resumen de cambios
echo -e "\n${BLUE}📊 Resumen de cambios:${NC}"
git diff --cached --stat

# Commit
echo -e "\n${GREEN}💾 Creando commit...${NC}"
git commit -m "$COMMIT_MSG" || {
    echo -e "${RED}❌ Error: Fallo al crear commit${NC}"
    exit 1
}
echo -e "${GREEN}✅ Commit creado: $COMMIT_MSG${NC}"

# Push del branch
echo -e "\n${YELLOW}🚀 Subiendo branch a GitHub...${NC}"
git push -u origin "$BRANCH_NAME" || {
    echo -e "${RED}❌ Error: Fallo al hacer push${NC}"
    exit 1
}
echo -e "${GREEN}✅ Branch subido exitosamente${NC}"

# Información para crear el PR
echo -e "\n${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ Sincronización completada${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "\n${YELLOW}📋 Información del Pull Request:${NC}"
echo -e "   Branch: ${GREEN}${BRANCH_NAME}${NC}"
echo -e "   Commit: ${GREEN}${COMMIT_MSG}${NC}"
echo -e "\n${YELLOW}🔧 Siguiente paso:${NC}"
echo -e "   DeepAgent creará automáticamente un Pull Request"
echo -e "   para que puedas revisar los cambios antes de mergear a main."
echo -e "\n${BLUE}═══════════════════════════════════════════════════════${NC}"

# Volver a main
git checkout main

# Exportar variables para que DeepAgent las use
echo -e "\n${GREEN}📤 Variables exportadas para crear PR:${NC}"
echo "BRANCH_NAME=$BRANCH_NAME"
echo "COMMIT_MSG=$COMMIT_MSG"
