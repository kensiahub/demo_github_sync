#!/bin/bash

# Script de ayuda para sincronización rápida

echo "🔄 Script de Sincronización DeepAgent ↔ GitHub"
echo "=============================================="
echo ""
echo "Selecciona una opción:"
echo ""
echo "1) 📤 Push: Enviar cambios locales a GitHub"
echo "2) 📥 Pull: Traer cambios de GitHub a local"
echo "3) 📊 Status: Ver estado del repositorio"
echo "4) 📝 Log: Ver historial de commits"
echo "5) 🔍 Diff: Ver diferencias con GitHub"
echo "6) ❌ Salir"
echo ""
read -p "Opción: " option

cd /home/ubuntu/demo_github_sync

case $option in
    1)
        echo ""
        echo "📤 Pusheando cambios a GitHub..."
        git add .
        read -p "Mensaje del commit: " msg
        git commit -m "$msg"
        git push origin main
        echo "✓ Cambios enviados a GitHub"
        ;;
    2)
        echo ""
        echo "📥 Trayendo cambios de GitHub..."
        git pull origin main
        echo "✓ Cambios actualizados desde GitHub"
        ;;
    3)
        echo ""
        echo "📊 Estado del repositorio:"
        git status
        ;;
    4)
        echo ""
        echo "📝 Historial de commits:"
        git log --oneline --graph -10
        ;;
    5)
        echo ""
        echo "🔍 Diferencias con GitHub:"
        git fetch origin
        git diff main origin/main
        ;;
    6)
        echo "👋 ¡Hasta luego!"
        exit 0
        ;;
    *)
        echo "❌ Opción inválida"
        exit 1
        ;;
esac
