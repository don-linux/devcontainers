FROM oven/bun:1.3.13-alpine

WORKDIR /app

# Copy package files
COPY package.json bun.lock ./

# Install dependencies
RUN bun install --frozen-lockfile --production && bun pm cache rm

# Copy source code
COPY . .

# Build the application
RUN bun run generate