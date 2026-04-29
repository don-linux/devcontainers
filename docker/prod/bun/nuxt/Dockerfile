FROM oven/bun:1.3.13-alpine AS builder

WORKDIR /app

# Copy package files
COPY package.json bun.lock ./

# Install dependencies
RUN bun install --frozen-lockfile

# Copy source code
COPY . .

# Build the application
RUN bun run generate

# Stage 2: Create the production image
FROM alpine:3.23 AS dist

WORKDIR /app

# Copy the built application
COPY --from=builder /app/.output/public /app/.output/public