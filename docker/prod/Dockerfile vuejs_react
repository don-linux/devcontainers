# Stage 1: Build the application
FROM node:24.14.0-alpine3.23 AS build

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
FROM alpine:3.23.3

WORKDIR /app

# Copy all files from build stage
COPY --from=build /app/dist ./dist