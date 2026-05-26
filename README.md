# Devcontainers templates

Plantillas de `Docker` y `Dev Containers` para preparar entornos reutilizables de desarrollo y una base de despliegue.

## Qué organiza

- Configuraciones listas para `Dev Containers`.
- Plantillas Docker separadas por entorno, runtime y stack.
- Una base reutilizable para no rehacer contenedores en cada proyecto.

## Estructura actual

La organización agrupa todo por carpeta, no por archivos sueltos al mismo nivel.

Ruta base de las plantillas Docker:

`docker/{dev|prod}/{runtime}/{stack}/`

```text
.devcontainer/
  bun/
    express/   nuxt/   react/   vue/
  node/
    express/   nuxt/   react/   vue/
  django/

docker/
  dev/
    bun/
      express/   nuxt/   react/   vue/
    node/
      express/   nuxt/   react/   vue/
  prod/
    bun/
      express/   nuxt/   react/   vue/
    node/
      express/   nuxt/   react/   vue/

docs/
  Error EACCES.md
  watchers.md
```

## Qué hay en cada zona

- `.devcontainer/`: configuración para abrir el proyecto dentro del editor con contenedores. Cada carpeta contiene `devcontainer.json` y un `compose.yaml` que extiende al de `docker/dev/`.
- `docker/dev/`: plantillas orientadas a desarrollo local. Cada stack incluye:
  - `Dockerfile`: imagen base del runtime con `bash`, `git`, `openssh-client` y soporte para mapear `USER_UID` / `USER_GID` al usuario del host.
  - `compose.yaml`: monta el código como volumen, expone el puerto del stack y deja el contenedor vivo para que el devcontainer ejecute los comandos.
  - `.env.example`: variables que consume el `compose.yaml` (nombre del proyecto, puerto y UID/GID).
- `docker/prod/`: plantillas orientadas a build y ejecución.
  - Servidores (`express`): imagen única con `npm ci` / `bun install --production` y `CMD` final.
  - Frontends (`nuxt`, `react`, `vue`): build multi-stage que deja los assets en `/dist` o `/app/.output/public` y los copia a un volumen del host.
- `docs/`: notas y soluciones a problemas recurrentes (ver más abajo).

## Cómo usar una plantilla

1. Copia la carpeta del stack que necesitas a tu proyecto.
   - Para abrir con Dev Containers: copia `.devcontainer/{runtime}/{stack}/` como `.devcontainer/` en la raíz, y `docker/dev/{runtime}/{stack}/` como `docker/dev/`.
   - Para usar Docker directo: copia solo `docker/dev/{runtime}/{stack}/` y/o `docker/prod/{runtime}/{stack}/`.
2. Renombra `.env.example` a `.env` y ajusta los valores.
3. Levanta el entorno:

   ```bash
   docker compose -f docker/dev/compose.yaml --env-file docker/dev/.env up --build
   ```

   En producción cambia `dev` por `prod`.
4. Si usas Dev Containers, abre el proyecto en el editor y selecciona "Reopen in Container".

## Variables de entorno

Las plantillas leen estas variables desde el `.env` del entorno correspondiente:

| Variable | Dónde | Descripción |
| --- | --- | --- |
| `DOCKER_DEV_NAME` / `DOCKER_PROD_NAME` | dev / prod | Nombre del proyecto en Compose. |
| `DOCKER_DEV_{STACK}_PORT` | dev | Puerto del host expuesto por el stack (5173 Vue, 3000 Nuxt/React, 5000 Express). |
| `DOCKER_PROD_{STACK}_PORT` | prod | Puerto del host expuesto en producción (solo aplica a servidores). |
| `USER_UID` / `USER_GID` | dev | UID y GID del usuario del host. Evita problemas de permisos en los volúmenes. Obtener con `id -u` y `id -g`. |

## Soporte actual

- Runtimes: `Node.js` (`node:24.15.0-alpine3.23`), `Bun` (`oven/bun:1.3.13-alpine`).
- Stacks con plantillas Docker: `Express`, `Nuxt`, `React`, `Vue`.
- Stack adicional solo en Dev Containers: `Django`.

## Notas y problemas conocidos

- Permisos `EACCES` al construir el contenedor o al instalar dependencias: ver [`docs/Error EACCES.md`](docs/Error%20EACCES.md).
- Hot reload de Vite / webpack no detecta cambios dentro del contenedor: aplica el snippet de [`docs/watchers.md`](docs/watchers.md).
