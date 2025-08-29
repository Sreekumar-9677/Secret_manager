# # Stage 1: Build Angular App
# FROM node:20 AS builder
# WORKDIR /app

# # Install dependencies
# COPY package*.json ./
# RUN npm install

# # Copy source code and build
# COPY . .
# RUN npm run build --configuration=production

# # Stage 2: Serve with NGINX
# FROM nginx:alpine
# WORKDIR /usr/share/nginx/html

# # Remove default NGINX config
# RUN rm /etc/nginx/conf.d/default.conf

# # Copy Angular build output
# COPY --from=builder /app/dist/my-secret-app/browser .


# # Copy NGINX template config
# COPY nginx.conf.template /etc/nginx/templates/default.conf.template

# # Install envsubst to replace ${PORT} at runtime
# RUN apk add --no-cache gettext

# # Replace ${PORT} and start NGINX in foreground
# CMD envsubst '${PORT}' < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf \
# && nginx -g 'daemon off;'


# # Expose Cloud Run port
# EXPOSE 8080
# Stage 1: Build Angular app
# Stage 1: Build Angular app
FROM node:20 AS builder
WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy custom Nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy Angular build output
COPY --from=builder /app/dist/my-secret-app/browser /usr/share/nginx/html

# Expose Cloud Run port
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]



