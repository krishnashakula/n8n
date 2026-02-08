# Optional Dockerfile for n8n deployment
# Use this if you prefer Docker-based deployment on Render

FROM node:18-alpine

# Install n8n globally
RUN npm install -g n8n

# Set working directory
WORKDIR /data

# Expose port
EXPOSE 5678

# Set environment variables
ENV N8N_PORT=5678

# Start n8n
CMD ["n8n", "start"]
