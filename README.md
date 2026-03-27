# Devcontainers templates

Plantillas de `Docker` y `Dev Containers` para preparar entornos reutilizables de desarrollo y base de despliegue.

## Qué organiza

- Configuraciones listas para `Dev Containers`.
- Plantillas Docker separadas por entorno, runtime y stack.
- Una base reutilizable para no rehacer contenedores en cada proyecto.

## Estructura actual

La organización nueva agrupa todo por carpeta, no por archivos sueltos al mismo nivel.

Ruta base:

`docker/{dev|prod}/{runtime}/{stack}/`

```text
.devcontainer/
  bun/
    express/ nuxt/ react/ vue/
  node/
    express/ nuxt/ react/ vue/
  django/

docker/
  dev/
    bun/
      express/ nuxt/ react/ vue/
    node/
      express/ nuxt/ react/ vue/
  prod/
    bun/
      express/ nuxt/ react/ vue/
    node/
      express/ nuxt/ react/ vue/
```

## Qué hay en cada zona

- `.devcontainer/`: configuración para abrir el proyecto dentro del editor con contenedores.
- `docker/dev/`: plantillas orientadas a desarrollo local.
- `docker/prod/`: plantillas orientadas a build y ejecución.
- Cada stack en `docker/` agrupa normalmente `Dockerfile`, `compose` y `.env.example`.

## Soporte actual

- Runtimes: `Node.js`, `Bun`
- Stacks con plantillas Docker: `Express`, `Nuxt`, `React`, `Vue`
- Stack adicional en `Dev Containers`: `Django`
