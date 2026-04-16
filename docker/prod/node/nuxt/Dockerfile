# Stage 1: Build the application
FROM node:24.15.0-alpine3.23 AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production \
    && npm cache clean --force

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Production image
FROM alpine:3.23.4

WORKDIR /app

# Set ownership and permissions
RUN addgroup -S app && adduser -S app -G app

# Copy built files from build stage
COPY --from=build --chown=app:app /app/dist ./dist

# Switch to non-root user
USER app