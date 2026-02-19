# Demo GitHub Sync

Proyecto de demostración para integración bidireccional GitHub CI/CD con DeepAgent.

## 📁 Estructura del Proyecto

```
demo_github_sync/
├── index.html    # Aplicación web de demostración
├── sync.sh       # Script de sincronización rápida
└── README.md     # Documentación (este archivo)
```

---

## 🔧 Cómo Funciona la Integración GitHub + DeepAgent

### Arquitectura Técnica

```
┌─────────────────┐     HTTPS/API      ┌─────────────────┐
│   DeepAgent     │◄──────────────────►│     GitHub      │
│  (Abacus.AI)    │                    │   (Repositorio) │
└────────┬────────┘                    └────────┬────────┘
         │                                      │
         │ Clona/Push via                       │ Clone/Pull
         │ GitHub App Token                     │
         │                                      │
         ▼                                      ▼
┌─────────────────┐                    ┌─────────────────┐
│ /home/ubuntu/   │                    │  Tu Máquina     │
│ demo_github_sync│                    │     Local       │
└─────────────────┘                    └─────────────────┘
```

### Componentes Clave

| Componente | Función |
|------------|---------|
| **GitHub App (Abacus.AI)** | Proporciona autenticación OAuth para DeepAgent |
| **Git Tool** | Herramienta nativa de DeepAgent para operaciones Git |
| **Token de Acceso** | Generado dinámicamente por sesión (`ghu_*`) |
| **Sparse Checkout** | Clonación eficiente (solo archivos necesarios) |

### Flujo de Autenticación

1. **Conexión inicial**: Usuario autoriza la GitHub App de Abacus.AI
2. **Token dinámico**: DeepAgent obtiene token temporal via `get_github_access_token`
3. **Operaciones Git**: Se ejecutan con el token embebido en la URL:
   ```
   https://x-access-token:{TOKEN}@github.com/user/repo.git
   ```

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
/home/ubuntu/github_repos/  # Para proyectos gestionados
/home/ubuntu/               # Para proyectos temporales
```

### 3. Configuración Git
```bash
git config user.name "cestebanmq"
git config user.email "cestebanmq@users.noreply.github.com"
```

---

## 🔄 Sincronización: Dos Opciones

### Opción 1: Script `sync.sh` (Recomendado)

```bash
# Dar permisos de ejecución (solo la primera vez)
chmod +x sync.sh

# Con mensaje personalizado
./sync.sh "feat: nueva funcionalidad"

# Con mensaje automático (incluye fecha/hora)
./sync.sh
```

**¿Qué hace el script?**
1. `git add .` - Agrega todos los cambios
2. Verifica si hay cambios pendientes
3. `git commit -m "mensaje"` - Crea el commit
4. `git push origin main` - Sube a GitHub

### Opción 2: Comandos Git Manuales

```bash
# Ver estado actual
git status

# Agregar cambios específicos
git add archivo.html
# O todos los cambios
git add .

# Crear commit
git commit -m "descripción del cambio"

# Subir a GitHub
git push origin main
```

---

## 🔁 Flujo Bidireccional

### DeepAgent → GitHub → Local

```bash
# En DeepAgent: hacer cambios y push
./sync.sh "cambios desde DeepAgent"

# En tu máquina local: obtener cambios
git pull origin main
```

### Local → GitHub → DeepAgent

```bash
# En tu máquina local: hacer cambios y push
git add . && git commit -m "cambios locales" && git push

# En DeepAgent: obtener cambios
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

# 2. Clonar repositorio (DeepAgent obtiene token automáticamente)
# El token se inyecta via Git_Tool

# 3. Configurar identidad
git config user.name "tu-usuario"
git config user.email "tu-usuario@users.noreply.github.com"

# 4. Trabajar normalmente con git
```

### Notas Técnicas Importantes

| Aspecto | Detalle |
|---------|---------|
| **Profundidad de clone** | Usar `--depth=50` para eficiencia |
| **Sparse checkout** | Activar para repos grandes |
| **Force push** | ⚠️ Evitar en `main`/`master` |
| **PRs** | Recomendado para cambios significativos |

---

## 📚 Recursos

- [GitHub App de Abacus.AI](https://github.com/apps/abacusai/installations/select_target)
- [Documentación DeepAgent](https://abacus.ai/help/chatllm-ai-super-assistant/introduction)
- [Repositorio en GitHub](https://github.com/cestebanmq/demo_github_sync)

---

*Última actualización: Febrero 2026*
