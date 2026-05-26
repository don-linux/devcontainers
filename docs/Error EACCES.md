# Evitar error EACCES en Docker

Cuando un repo se clona con `sudo` o la carpeta del proyecto no pertenece al mismo `UID` y `GID` que usa el contenedor, pueden aparecer errores de permisos como `EACCES`

Para resolverlo, se deben realizar los siguientes comandos

Primero, cambiar a la rama objetivo:

```bash
git switch ramaObjetivo
```

Nos aseguramos que el proyecto pertenezca al usuario actual cambiando el propietario de la carpeta:

```bash
sudo chown -R "$(id -u):$(id -g)" .
```

Despues de esto, debemos identificar el UID y GID del usuario:

```bash
id -u && id -g
```

Al saber el UID y GID, se deben establecer en las variables de entorno del contenedor:

```bash
USER_UID=uid_del_usuario
USER_GID=gid_del_usuario
```

Despues procedemos a compilar el contenedor, y no deberia de darnos error de permisos

## Contenedor o volumen preexistente

Si el contenedor o sus volúmenes ya existían con permisos incorrectos, limpia el entorno antes de volver a levantarlo:

```bash
docker compose -f docker/dev/compose.yaml down -v && docker compose -f docker/dev/compose.yaml up --build
```

down -v elimina los contenedores y los volúmenes del proyecto
No corrige el owner del repo en el host, para eso se usa chown, por eso ayuda cuando el problema quedó en un volumen Docker como node_modules con un owner incorrecto

Asi al levantar de nuevo, Docker crea los contenedores y volúmenes desde cero con la configuración de permisos actual
