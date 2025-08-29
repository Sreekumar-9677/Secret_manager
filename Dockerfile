# Stage 1: Build Angular
FROM node:20 as builder
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy project and build
COPY . .
RUN npm run build --configuration production

# Stage 2: NGINX to serve Angular build
FROM nginx:alpine

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy your custom nginx.conf
COPY nginx.conf /etc/nginx/conf.d

# Copy built Angular app
COPY --from=builder /app/dist/my-secret-app/browser /usr/share/nginx/html

# Expose Cloud Run’s required port
EXPOSE 8080

# Run NGINX on 8080
CMD ["nginx", "-g", "daemon off;"]

# Stage 1: Build Angular app
# Stage 1: Build Angular app
# FROM node:20 AS builder
# WORKDIR /app

# COPY package.json package-lock.json ./
# RUN npm install

# COPY . .
# RUN npm run build -- --configuration production --project=my-secret-app


# # Stage 2: Serve with Nginx
# FROM nginx:alpine

# # Copy custom Nginx config
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# # Copy Angular build output
# COPY --from=builder /app/dist/my-secret-app/browser /usr/share/nginx/html

# # Expose Cloud Run port
# EXPOSE 8080

# CMD ["nginx", "-g", "daemon off;"]



