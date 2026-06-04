# 🚀 Instrucciones de configuración — Mi Cartera

## Paso 1 — Crear proyecto en Supabase

1. Ve a [supabase.com](https://supabase.com) e inicia sesión
2. Clic en **"New project"**
3. Ponle nombre: `mi-cartera`
4. Elige una contraseña segura para la base de datos
5. Región: **South America (São Paulo)** — la más cercana a Colombia
6. Clic en **"Create new project"** y espera ~2 minutos

---

## Paso 2 — Ejecutar el SQL

1. En tu proyecto Supabase, ve al menú izquierdo → **SQL Editor**
2. Clic en **"New query"**
3. Pega todo el contenido del archivo `supabase_setup.sql`
4. Clic en **"Run"** (botón verde)
5. Debes ver: *"Success. No rows returned"*

---

## Paso 3 — Obtener tus credenciales

1. Ve a **Settings → API** en el menú izquierdo
2. Copia estos dos valores:
   - **Project URL** → algo como `https://xxxxxxxx.supabase.co`
   - **anon public key** → cadena larga que empieza con `eyJ...`

---

## Paso 4 — Configurar el index.html

1. Abre el archivo `index.html` en cualquier editor de texto
2. Busca estas dos líneas cerca del inicio del `<script>`:
   ```
   const SUPABASE_URL = 'TU_URL_AQUI';
   const SUPABASE_KEY = 'TU_ANON_KEY_AQUI';
   ```
3. Reemplaza con tus valores reales

---

## Paso 5 — Subir a GitHub Pages

1. Ve a [github.com](https://github.com) con tu cuenta `ARAMIS8984`
2. Crea repositorio nuevo → nombre: `cartera`
3. Sube el archivo `index.html`
4. Ve a **Settings → Pages → Branch: main → Save**
5. Tu app estará en: `https://ARAMIS8984.github.io/cartera`

---

## Paso 6 — Primer ingreso

- **Supervisor** → usuario: `supervisor` / contraseña: `super2024`
- **Admin** → usuario: `admin` / contraseña: `admin2024`

⚠️ **Cambia estas contraseñas inmediatamente desde la app** (menú ⚙️ → Cambiar contraseña)

---

## Permisos por rol

| Acción | Admin | Supervisor |
|--------|:-----:|:----------:|
| Ver registros y alertas | ✅ | ✅ |
| Registrar nuevo préstamo/venta | ✅ | ✅ |
| Registrar abonos | ✅ | ✅ |
| Generar PDFs de cobro/pago | ✅ | ✅ |
| Editar registro ya guardado | ❌ | ✅ |
| Eliminar registros | ❌ | ✅ |
| Configurar datos del negocio | ❌ | ✅ |
| Cambiar contraseñas | ❌ | ✅ |

---

## Acceso desde cualquier dispositivo

Una vez publicado en GitHub Pages, abres la misma URL desde cualquier dispositivo:
- 📱 Celular: `https://ARAMIS8984.github.io/cartera`
- 💻 Computador: la misma URL
- Los datos se sincronizan en tiempo real vía Supabase
