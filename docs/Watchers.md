# Hot reload dentro del contenedor

Cuando montas el código del host en el contenedor con un volumen, las herramientas de desarrollo (Vite, webpack, Nuxt, etc.) a veces no detectan los cambios porque los eventos de `inotify` no se propagan correctamente entre el host y el contenedor.

La solución es forzar el modo "polling" en los watchers.

## Cómo aplicarlo

Agrega estas variables al servicio en el `compose.yaml` de desarrollo (por ejemplo `docker/dev/{runtime}/{stack}/compose.yaml`):

```yaml
services:
  miServicio:
    environment:
      CHOKIDAR_USEPOLLING: 'true'
      WATCHPACK_POLLING: 'true'
```

- `CHOKIDAR_USEPOLLING`: activa polling en chokidar, usado por Vite, Vue CLI, Nuxt, etc.
- `WATCHPACK_POLLING`: activa polling en watchpack, usado por webpack y Next.js.

## Cuándo usarlo

- Cuando guardas un archivo y la app no recarga.
- Cuando trabajas en Windows o macOS con Docker Desktop y volúmenes "bind".
- Cuando trabajas dentro de WSL con el proyecto en otro sistema de archivos.

> El polling consume más CPU que los eventos nativos. Úsalo solo en desarrollo y solo si lo necesitas.
