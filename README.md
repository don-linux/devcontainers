# Devcontainers templates

Repositorio de plantillas Docker para levantar entornos de desarrollo y despliegue

## Para que sirve

- Centraliza configuraciones reutilizables de contenedores.
- Separa plantillas de desarrollo y producción.
- Permite trabajar con distintos runtimes y stacks frontend/backend sin recrear la base Docker cada vez.

## Estructura

### Raiz

- `docker/`: plantillas principales del proyecto.

### `docker/dev/`

Plantillas orientadas a desarrollo local.

- `bun/`: entorno de desarrollo basado en Bun.
- `node/`: entorno de desarrollo basado en Node.js.

Archivos habituales en cada runtime:

- `Dockerfile ...`: imagen base para los stacks soportados.
- `compose *.yaml`: composiciones Docker por framework o tipo de app.

### `docker/prod/`

Plantillas orientadas a ejecucion o despliegue.

- `Dockerfile express`: imagen para Express con Node.js.
- `Dockerfile express bun`: imagen para Express con Bun.
- `Dockerfile vuejs_nuxt_react`: imagen para apps frontend con Node.js.
- `Dockerfile vuejs_nuxt_react bun`: imagen para apps frontend con Bun.
- `compose *.yaml`: composiciones para cada stack soportado.
- `.env.example`: variables de entorno de ejemplo.

## Soporte actual

### Runtimes

- Node.js
- Bun

### Frameworks y stacks

- Express
- Django
- React
- Vue.js
- Nuxt