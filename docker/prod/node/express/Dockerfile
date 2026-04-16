# Stage 1: Build the application
FROM node:24.15.0-alpine3.23

WORKDIR /app

# Copy package files
COPY package.json bun.lock ./

# Install dependencies
RUN npm ci --only=production \
    && npm cache clean --force

# Copy source code
COPY index.mjs ./
COPY src ./src

# Set ownership and permissions
RUN chown -R bun:bun /app

# Switch to non-root user
USER bun

EXPOSE 5000

ENV NODE_ENV=production

CMD ["bun", "run", "start"]