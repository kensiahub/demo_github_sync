# 🚀 Demo GitHub Sync - DeepAgent

Este es un proyecto de demostración para sincronización bidireccional entre DeepAgent y GitHub.

## 📁 Estructura del Proyecto

```
demo_github_sync/
├── index.html                    # Aplicación web demo
├── GUIA_SINCRONIZACION.md       # Guía completa de configuración
├── sync.sh                       # Script de ayuda para sincronización
└── README.md                     # Este archivo
```

## 🎯 Estado Actual

✅ **Configuración Base Completada:**
- ✓ Repositorio local inicializado
- ✓ Git configurado con identidad correcta
- ✓ Remote de GitHub conectado
- ✓ Archivo demo modificado con cambios de prueba
- ✓ Commits locales creados

⚠️ **Acción Requerida:**
Para habilitar la sincronización automática, necesitas configurar los permisos de la GitHub App de Abacus.AI:

👉 **[Configurar Permisos Aquí](https://github.com/apps/abacusai/installations/select_target)**

## 🔄 Métodos de Sincronización

### Opción 1: Script de Ayuda Rápida
```bash
cd /home/ubuntu/demo_github_sync
./sync.sh
```

### Opción 2: Comandos Git Manuales
```bash
# Push a GitHub
git add .
git commit -m "Tu mensaje"
git push origin main

# Pull desde GitHub
git pull origin main
```

### Opción 3: Sincronización Automática (Requiere configuración)
Ver `GUIA_SINCRONIZACION.md` para instrucciones detalladas.

## 📖 Documentación

- **Guía Completa:** [GUIA_SINCRONIZACION.md](./GUIA_SINCRONIZACION.md)
- **Repositorio GitHub:** https://github.com/kensiahub/demo_github_sync
- **Documentación CI/CD:** https://abacus.ai/help/python-sdk/github_cicd

## 🧪 Prueba Rápida

1. **Edita el archivo:**
   ```bash
   nano index.html
   ```

2. **Sincroniza con GitHub:**
   ```bash
   ./sync.sh
   # Selecciona opción 1 (Push)
   ```

3. **Verifica en GitHub:**
   https://github.com/kensiahub/demo_github_sync

## 🆘 Ayuda

Si encuentras problemas, consulta la sección "Solución de Problemas" en `GUIA_SINCRONIZACION.md`.

---

**Proyecto creado:** 19 de febrero de 2026  
**Última actualización:** 19 de febrero de 2026
