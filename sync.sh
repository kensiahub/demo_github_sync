#!/bin/bash
# sync.sh - Script de sincronización rápida con GitHub
# Uso: ./sync.sh "mensaje de commit"
#      ./sync.sh (usa mensaje por defecto)

set -e

# Mensaje de commit (parámetro o por defecto)
COMMIT_MSG="${1:-Actualización desde DeepAgent $(date '+%Y-%m-%d %H:%M')}"

echo "🔄 Sincronizando con GitHub..."

# Agregar todos los cambios
git add .

# Verificar si hay cambios para commitear
if git diff --cached --quiet; then
    echo "✅ No hay cambios para sincronizar"
    exit 0
fi

# Commit
git commit -m "$COMMIT_MSG"
echo "📝 Commit: $COMMIT_MSG"

# Push
git push origin main
echo "🚀 Push completado exitosamente"
