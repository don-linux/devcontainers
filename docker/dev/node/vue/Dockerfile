FROM node:24.15.0-alpine3.23

RUN apk add --no-cache git openssh-client bash

WORKDIR /app

RUN chown node:node /app

USER node

CMD ["sleep", "infinity"]

# Doesn't need COPY since devcontainer mounts the workspace, devcontainer keep the container alive
# and then executes postStartCommand