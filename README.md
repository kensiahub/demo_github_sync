# Demo GitHub Sync

Proyecto de demostración para integración bidireccional GitHub CI/CD con DeepAgent, implementando **mejores prácticas de desarrollo colaborativo** mediante Pull Requests.

## 📁 Estructura del Proyecto

```
demo_github_sync/
├── index.html    # Aplicación web de demostración
├── sync.sh       # Script de sincronización con flujo de PR
└── README.md     # Documentación (este archivo)
```

---

## 🎯 Flujo de Trabajo con Pull Requests

### ¿Por qué usar Pull Requests?

Este proyecto implementa un flujo de trabajo basado en **Pull Requests (PRs)** en lugar de push directo a `main`. Esto proporciona:

✅ **Revisión de código**: Otro desarrollador puede revisar cambios antes de mergear  
✅ **Control de calidad**: Detectar errores antes de que lleguen a producción  
✅ **Historial claro**: Cada cambio queda documentado con su contexto  
✅ **Colaboración segura**: Evita conflictos y cambios accidentales en main  
✅ **Mejor práctica**: Estándar en equipos de desarrollo profesionales  

### Arquitectura del Flujo

```
┌─────────────────┐
│   DeepAgent     │
│  Hace cambios   │
└────────┬────────┘
         │
         ▼
┌─────────────────────────────────────┐
│  sync.sh ejecuta:                   │
│  1. Crea branch: deepagent/sync-*   │
│  2. Commit de cambios               │
│  3. Push del branch                 │
└────────┬────────────────────────────┘
         │
         ▼
┌─────────────────────────────────────┐
│  DeepAgent crea Pull Request        │
│  - Título descriptivo               │
│  - Descripción de cambios           │
│  - Link para revisión               │
└────────┬────────────────────────────┘
         │
         ▼
┌─────────────────────────────────────┐
│  Desarrollador revisa PR            │
│  - Verifica cambios                 │
│  - Aprueba o solicita cambios       │
│  - Mergea a main                    │
└─────────────────────────────────────┘
```

---

## 🔧 Cómo Funciona la Integración GitHub + DeepAgent

### Arquitectura Técnica

```
┌─────────────────┐     HTTPS/API      ┌─────────────────┐
│   DeepAgent     │◄──────────────────►│     GitHub      │
│  (Abacus.AI)    │   Pull Requests    │   (Repositorio) │
└────────┬────────┘                    └────────┬────────┘
         │                                      │
         │ Clona/Push via                       │ Clone/Pull
         │ GitHub App Token                     │ Review/Merge
         │                                      │
         ▼                                      ▼
┌─────────────────┐                    ┌─────────────────┐
│ /home/ubuntu/   │                    │  Tu Máquina     │
│ github_repos/   │                    │     Local       │
│ demo_github_sync│                    │                 │
└─────────────────┘                    └─────────────────┘
```

### Componentes Clave

| Componente | Función |
|------------|---------|
| **GitHub App (Abacus.AI)** | Proporciona autenticación OAuth para DeepAgent |
| **Git Tool** | Herramienta nativa de DeepAgent para operaciones Git y PRs |
| **Token de Acceso** | Generado dinámicamente por sesión (`ghu_*`) |
| **Sparse Checkout** | Clonación eficiente (solo archivos necesarios) |
| **Feature Branches** | Branches temporales para cada sincronización |

---

## ⚙️ Configuración Realizada

### 1. GitHub App (Permisos)
La integración requiere autorizar la [GitHub App de Abacus.AI](https://github.com/apps/abacusai/installations/select_target) con:

- ✅ **Contents**: Lectura/escritura de archivos
- ✅ **Pull Requests**: Crear y gestionar PRs
- ✅ **Metadata**: Acceso a información del repositorio

### 2. Clonación en DeepAgent
```bash
# Ubicación estándar para repos en DeepAgent
/home/ubuntu/github_repos/demo_github_sync/
```

### 3. Configuración Git
```bash
git config user.name "cestebanmq"
git config user.email "cestebanmq@users.noreply.github.com"
```

---

## 🔄 Uso del Script de Sincronización

### Script `sync.sh` - Flujo Automático con PR

```bash
# Dar permisos de ejecución (solo la primera vez)
chmod +x sync.sh

# Con mensaje personalizado
./sync.sh "feat: nueva funcionalidad en el dashboard"

# Con mensaje automático (incluye fecha/hora)
./sync.sh
```

### ¿Qué hace el script automáticamente?

1. **Actualiza main**: `git pull origin main`
2. **Crea branch único**: `deepagent/sync-YYYYMMDD-HHMMSS`
3. **Agrega cambios**: `git add .`
4. **Verifica cambios**: Si no hay cambios, termina limpiamente
5. **Muestra resumen**: `git diff --cached --stat`
6. **Crea commit**: Con el mensaje proporcionado
7. **Sube branch**: `git push -u origin <branch>`
8. **Prepara info**: Para que DeepAgent cree el PR automáticamente

### Salida del Script

```
🔄 Iniciando sincronización con GitHub (flujo PR)...

📥 Actualizando rama main...
✅ Ya está actualizado

🌿 Creando branch: deepagent/sync-20260219-143022

📝 Agregando cambios...

📊 Resumen de cambios:
 index.html | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

💾 Creando commit...
✅ Commit creado: feat: nueva funcionalidad en el dashboard

🚀 Subiendo branch a GitHub...
✅ Branch subido exitosamente

═══════════════════════════════════════════════════════
✅ Sincronización completada
═══════════════════════════════════════════════════════

📋 Información del Pull Request:
   Branch: deepagent/sync-20260219-143022
   Commit: feat: nueva funcionalidad en el dashboard

🔧 Siguiente paso:
   DeepAgent creará automáticamente un Pull Request
   para que puedas revisar los cambios antes de mergear a main.

═══════════════════════════════════════════════════════
```

---

## 👀 Revisión y Merge de Pull Requests

### Opción 1: Interfaz Web de GitHub (Recomendado)

1. **Recibir notificación**: DeepAgent te dará el link del PR
2. **Abrir PR en GitHub**: Click en el link proporcionado
3. **Revisar cambios**: 
   - Ver archivos modificados en la pestaña "Files changed"
   - Revisar el diff de cada archivo
   - Agregar comentarios si es necesario
4. **Aprobar y mergear**:
   - Click en "Merge pull request"
   - Confirmar el merge
   - Opcionalmente, eliminar el branch después del merge

### Opción 2: Línea de Comandos

```bash
# En tu máquina local o en DeepAgent

# 1. Actualizar referencias
git fetch origin

# 2. Ver el PR localmente (opcional)
git checkout deepagent/sync-YYYYMMDD-HHMMSS
git log -1
git diff main

# 3. Volver a main y mergear
git checkout main
git merge deepagent/sync-YYYYMMDD-HHMMSS

# 4. Subir el merge
git push origin main

# 5. Eliminar branch (opcional)
git branch -d deepagent/sync-YYYYMMDD-HHMMSS
git push origin --delete deepagent/sync-YYYYMMDD-HHMMSS
```

### Opción 3: GitHub CLI (gh)

```bash
# Ver PRs abiertos
gh pr list

# Ver detalles de un PR
gh pr view <número>

# Revisar cambios
gh pr diff <número>

# Mergear PR
gh pr merge <número> --merge --delete-branch
```

---

## 🔁 Flujo Bidireccional Completo

### DeepAgent → GitHub → Local

```bash
# 1. En DeepAgent: hacer cambios y ejecutar sync
./sync.sh "cambios desde DeepAgent"

# 2. DeepAgent crea PR automáticamente
# (Recibes link del PR)

# 3. En GitHub Web: revisar y mergear PR

# 4. En tu máquina local: obtener cambios mergeados
git pull origin main
```

### Local → GitHub → DeepAgent

```bash
# 1. En tu máquina local: hacer cambios
git checkout -b feature/mi-cambio
git add .
git commit -m "mi cambio local"
git push origin feature/mi-cambio

# 2. En GitHub Web: crear PR y mergear

# 3. En DeepAgent: obtener cambios
cd /home/ubuntu/github_repos/demo_github_sync
git pull origin main
```

---

## 🛠️ Para Desarrolladores: Replicar esta Integración

### Requisitos Previos
1. Cuenta de GitHub
2. Acceso a DeepAgent (Abacus.AI)
3. Autorizar GitHub App: [Instalar aquí](https://github.com/apps/abacusai/installations/select_target)

### Pasos para Nuevo Proyecto

```bash
# 1. En DeepAgent, crear directorio
mkdir -p /home/ubuntu/github_repos
cd /home/ubuntu/github_repos

# 2. Clonar repositorio (sparse y con profundidad limitada)
git clone --depth 50 --filter=blob:none --sparse \
    https://github.com/usuario/repo.git
cd repo
git sparse-checkout init --cone
git sparse-checkout set .

# 3. Configurar identidad
git config user.name "tu-usuario"
git config user.email "tu-usuario@users.noreply.github.com"

# 4. Copiar sync.sh de este proyecto
# (Ajustar según necesidades)

# 5. Trabajar con el flujo de PR
./sync.sh "primer cambio"
```

### Notas Técnicas Importantes

| Aspecto | Detalle |
|---------|---------|
| **Profundidad de clone** | `--depth=50` para eficiencia |
| **Sparse checkout** | Activar para repos grandes |
| **Force push** | ⚠️ **NUNCA** en `main`/`master` |
| **Feature branches** | ✅ Siempre para cambios |
| **PRs** | ✅ Obligatorio para todos los cambios |
| **Naming branches** | `deepagent/sync-TIMESTAMP` para sincronización |

---

## 🚨 Solución de Problemas

### Error: "No se pudo crear el branch"
```bash
# Verificar que estás en main
git checkout main
git pull origin main

# Limpiar branches locales huérfanos
git fetch --prune
```

### Error: "Fallo al hacer push"
```bash
# Verificar permisos de GitHub App
# Ir a: https://github.com/apps/abacusai/installations/select_target

# Verificar que el token es válido
# DeepAgent regenera tokens automáticamente
```

### Conflictos de Merge
```bash
# Si hay conflictos al mergear un PR:
git checkout main
git pull origin main
git checkout deepagent/sync-XXXXXX
git rebase main

# Resolver conflictos manualmente
git add .
git rebase --continue
git push origin deepagent/sync-XXXXXX --force
```

---

## 📚 Recursos

- [GitHub App de Abacus.AI](https://github.com/apps/abacusai/installations/select_target)
- [Documentación DeepAgent](https://abacus.ai/help/chatllm-ai-super-assistant/introduction)
- [Repositorio en GitHub](https://github.com/kensiahub/demo_github_sync)
- [GitHub Pull Requests](https://docs.github.com/en/pull-requests)
- [Git Branching Strategy](https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows)

---

## 📝 Changelog

### v2.0 - Flujo con Pull Requests (Febrero 2026)
- ✅ Implementado flujo de trabajo con PRs
- ✅ Script sync.sh actualizado con creación automática de branches
- ✅ Documentación completa del proceso de revisión
- ✅ Mejores prácticas de desarrollo colaborativo

### v1.0 - Sincronización Directa (Febrero 2026)
- ✅ Integración básica GitHub + DeepAgent
- ✅ Script sync.sh con push directo a main
- ✅ Documentación inicial

---

*Última actualización: Febrero 2026*  
*Mantenido por: cestebanmq*
