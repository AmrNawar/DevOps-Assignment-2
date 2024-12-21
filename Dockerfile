# Stage 1: Build Frontend (admin)
FROM node:20 AS frontend
WORKDIR /app/admin

# Copy admin files
COPY admin/package.json admin/package-lock.json ./
RUN npm install

COPY admin/ ./

# Stage 2: Install and Prepare Backend (api)
FROM node:20 AS backend
WORKDIR /app/api

# Copy backend files
COPY api/package.json api/package-lock.json ./

COPY api/ ./

# Final Stage: Combine Builds and Run
FROM node:20
WORKDIR /app

# Copy backend files
COPY --from=backend /app/api ./api


# Expose backend port
EXPOSE 3000

# Start the backend server
CMD ["node", "./api/index.js"]
