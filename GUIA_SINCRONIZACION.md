# 🔄 Guía de Sincronización Bidireccional DeepAgent ↔ GitHub

## 📋 Estado Actual del Proyecto

✅ **Completado:**
- Proyecto local creado en `/home/ubuntu/demo_github_sync/`
- Repositorio GitHub: `kensiahub/demo_github_sync`
- Git inicializado localmente
- Archivo `index.html` modificado con texto "Hola Mundo - Sincronizado con GitHub"
- Commits locales creados
- GitHub conectado en DeepAgent

⚠️ **Pendiente:**
- Configurar permisos de escritura para la GitHub App de Abacus.AI
- Establecer sincronización automática bidireccional

---

## 🔧 Configuración Necesaria

### Paso 1: Dar Permisos a la GitHub App de Abacus.AI

Para que DeepAgent pueda pushear cambios automáticamente a GitHub, necesitas dar permisos de escritura a la GitHub App:

1. **Visita la página de configuración de la GitHub App:**
   👉 https://github.com/apps/abacusai/installations/select_target

2. **Selecciona tu cuenta** (`kensiahub`)

3. **En "Repository access", asegúrate de:**
   - Seleccionar "All repositories" O
   - Seleccionar "Only select repositories" y agregar `demo_github_sync`

4. **En "Permissions", verifica que tenga:**
   - ✅ Contents: Read and write
   - ✅ Pull requests: Read and write
   - ✅ Webhooks: Read and write

5. **Guarda los cambios**

---

## 🚀 Método 1: Sincronización Manual (Disponible Ahora)

Mientras configuras los permisos automáticos, puedes usar este método:

### A. Pushear cambios desde DeepAgent a GitHub:

```bash
cd /home/ubuntu/demo_github_sync

# 1. Hacer cambios en tus archivos
nano index.html  # o edita en el Code Editor de DeepAgent

# 2. Commitear cambios
git add .
git commit -m "Descripción de tus cambios"

# 3. Pushear a GitHub (necesitarás autenticación)
git push origin main
```

### B. Traer cambios desde GitHub a DeepAgent:

```bash
cd /home/ubuntu/demo_github_sync

# Traer los últimos cambios
git pull origin main
```

---

## ⚡ Método 2: Sincronización Automática con Abacus.AI CI/CD

Una vez que hayas configurado los permisos de la GitHub App, puedes usar las APIs de Abacus.AI:

### Configurar CI/CD con Python:

```python
import abacusai

# Cliente pre-autenticado
client = abacusai.ApiClient()

# Configurar webhook para sincronización bidireccional
webhook = client.create_deployment_webhook(
    # Parámetros según la documentación de Abacus.AI
    # Ver: https://abacus.ai/help/python-sdk/github_cicd
)

print(f"Webhook creado: {webhook}")
```

### Características de la sincronización automática:

✅ **DeepAgent → GitHub:**
- Los cambios en `/home/ubuntu/demo_github_sync/` se pushean automáticamente
- Se crean commits automáticos
- Se pueden configurar PRs automáticos

✅ **GitHub → DeepAgent:**
- Los cambios en GitHub se sincronizan automáticamente
- Se reciben notificaciones de nuevos commits
- Se actualiza el código local

---

## 🧪 Prueba de Sincronización

### Probar DeepAgent → GitHub:

1. **Edita el archivo localmente:**
   ```bash
   cd /home/ubuntu/demo_github_sync
   sed -i 's/Hola Mundo - Sincronizado con GitHub/Hola Mundo - Prueba de Sync/g' index.html
   ```

2. **Commitea y pushea:**
   ```bash
   git add index.html
   git commit -m "Prueba de sincronización"
   git push origin main
   ```

3. **Verifica en GitHub:**
   👉 https://github.com/kensiahub/demo_github_sync/blob/main/index.html

### Probar GitHub → DeepAgent:

1. **Edita el archivo en GitHub:**
   - Ve a: https://github.com/kensiahub/demo_github_sync
   - Haz clic en `index.html`
   - Haz clic en el ícono de lápiz (Edit)
   - Cambia algún texto
   - Haz commit directamente en `main`

2. **Trae los cambios a DeepAgent:**
   ```bash
   cd /home/ubuntu/demo_github_sync
   git pull origin main
   cat index.html  # Verifica los cambios
   ```

---

## 📊 Verificar Estado Actual

```bash
# Ver el estado del repositorio
cd /home/ubuntu/demo_github_sync
git status

# Ver el historial de commits
git log --oneline -10

# Ver diferencias con GitHub
git fetch origin
git diff main origin/main

# Ver la configuración del remote
git remote -v
```

---

## 🔗 Enlaces Útiles

- **Repositorio GitHub:** https://github.com/kensiahub/demo_github_sync
- **GitHub App Config:** https://github.com/apps/abacusai/installations/select_target
- **Documentación CI/CD:** https://abacus.ai/help/python-sdk/github_cicd
- **Proyecto Local:** `/home/ubuntu/demo_github_sync/`

---

## 🆘 Solución de Problemas

### Error: "Permission denied" al pushear

**Causa:** La GitHub App no tiene permisos de escritura.

**Solución:** 
1. Ve a https://github.com/apps/abacusai/installations/select_target
2. Configura los permisos como se indica en el Paso 1

### Error: "Resource not accessible by integration"

**Causa:** La GitHub App necesita permisos adicionales en el repositorio.

**Solución:**
1. Asegúrate de que el repositorio esté incluido en la instalación de la App
2. Verifica que los permisos de "Contents" estén en "Read and write"

### Los cambios no se sincronizan automáticamente

**Causa:** El webhook de CI/CD no está configurado.

**Solución:**
1. Usa el Método 2 (arriba) para configurar el webhook
2. O usa el Método 1 (manual) mientras tanto

---

## 📝 Próximos Pasos Recomendados

1. ✅ **Configurar permisos de la GitHub App** (Paso 1)
2. ✅ **Probar sincronización manual** (Método 1)
3. ✅ **Configurar CI/CD automático** (Método 2)
4. ✅ **Hacer pruebas bidireccionales**
5. ✅ **Documentar tu flujo de trabajo**

---

**Fecha de creación:** 19 de febrero de 2026  
**Versión:** 1.0
