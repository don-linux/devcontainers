FROM oven/bun:1.3.12-alpine

RUN apk add --no-cache git openssh-client bash wget

WORKDIR /app

RUN chown bun:bun /app

USER bun

CMD ["sleep", "infinity"]

# Doesn't need COPY since devcontainer mounts the workspace, devcontainer keep the container alive
# and then executes postStartCommand