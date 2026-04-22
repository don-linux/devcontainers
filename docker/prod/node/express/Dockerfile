FROM node:24.15.0-alpine3.23

WORKDIR /app
ENV NODE_ENV=production

# Copy package files
COPY --chown=node:node package*.json ./

# Install dependencies
RUN npm ci --omit=dev && npm cache clean --force

# Copy source code
COPY --chown=node:node index.mjs ./
COPY --chown=node:node src ./src

# Switch to non-root user
USER node

# Expose the port
EXPOSE 5000

# Start the application
CMD ["node", "index.mjs"]