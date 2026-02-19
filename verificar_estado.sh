#!/bin/bash

# Script de verificación del estado de sincronización

clear

echo "╔══════════════════════════════════════════════════════════════════════════════╗"
echo "║                                                                              ║"
echo "║              🔍 VERIFICACIÓN DE ESTADO - DeepAgent ↔ GitHub                  ║"
echo "║                                                                              ║"
echo "╚══════════════════════════════════════════════════════════════════════════════╝"
echo ""

cd /home/ubuntu/demo_github_sync

echo "📍 UBICACIÓN DEL PROYECTO"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Local:  /home/ubuntu/demo_github_sync/"
echo "GitHub: https://github.com/kensiahub/demo_github_sync"
echo ""

echo "📊 ESTADO DEL REPOSITORIO GIT"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
git status
echo ""

echo "📝 ÚLTIMOS 5 COMMITS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
git log --oneline --graph -5
echo ""

echo "🔗 CONFIGURACIÓN DEL REMOTE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
git remote -v | sed 's/ghu_[^ ]*/ghu_***TOKEN***/g'
echo ""

echo "📁 ARCHIVOS DEL PROYECTO"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ls -lh | grep -v "^d" | grep -v "^total"
echo ""

echo "🔄 DIFERENCIAS CON GITHUB"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
git fetch origin 2>/dev/null
DIFF_COUNT=$(git diff main origin/main --shortstat 2>/dev/null | wc -l)

if [ $DIFF_COUNT -eq 0 ]; then
    echo "✅ Tu repositorio local está sincronizado con GitHub"
else
    echo "⚠️  Hay diferencias entre local y GitHub:"
    git diff main origin/main --shortstat
    echo ""
    echo "Para ver las diferencias completas, ejecuta:"
    echo "  git diff main origin/main"
fi
echo ""

echo "✅ ARCHIVOS DE AYUDA DISPONIBLES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  📄 README.md                   - Resumen del proyecto"
echo "  📄 GUIA_SINCRONIZACION.md      - Guía completa y detallada"
echo "  📄 INSTRUCCIONES.html          - Instrucciones visuales"
echo "  📄 sync.sh                     - Script de sincronización rápida"
echo "  📄 verificar_estado.sh         - Este script"
echo ""

echo "🚀 COMANDOS RÁPIDOS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ./sync.sh                      - Sincronización interactiva"
echo "  git push origin main           - Enviar cambios a GitHub"
echo "  git pull origin main           - Traer cambios de GitHub"
echo "  ./verificar_estado.sh          - Ver este resumen"
echo ""

echo "🔗 ENLACES IMPORTANTES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🌐 Repositorio:  https://github.com/kensiahub/demo_github_sync"
echo "  ⚙️  GitHub App:  https://github.com/apps/abacusai/installations/select_target"
echo "  📖 Docs CI/CD:   https://abacus.ai/help/python-sdk/github_cicd"
echo ""

echo "╔══════════════════════════════════════════════════════════════════════════════╗"
echo "║                                                                              ║"
echo "║  ⚠️  RECORDATORIO: Configura los permisos de la GitHub App para             ║"
echo "║     habilitar la sincronización automática bidireccional                    ║"
echo "║                                                                              ║"
echo "║  👉 https://github.com/apps/abacusai/installations/select_target            ║"
echo "║                                                                              ║"
echo "╚══════════════════════════════════════════════════════════════════════════════╝"
echo ""

