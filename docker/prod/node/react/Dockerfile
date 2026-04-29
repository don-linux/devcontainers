# Stage 1: Build the application
FROM node:24.15.0-alpine3.23 AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Create the production image
FROM alpine:3.23 AS dist

WORKDIR /app

# Copy the built application
COPY --from=builder /app/dist ./dist