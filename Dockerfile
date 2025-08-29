# Stage 1: Build Angular App
FROM node:20 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --configuration=production

# Stage 2: Serve with NGINX
FROM nginx:alpine
WORKDIR /usr/share/nginx/html

# Remove default config
RUN rm /etc/nginx/conf.d/default.conf

# Copy Angular build
COPY --from=builder /app/dist/my-secret-app/browser .

# Copy Nginx template config
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

# Install envsubst
RUN apk add --no-cache gettext

# Replace template variables and start NGINX
CMD envsubst '${PORT}' < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'

# Expose Cloud Run port
EXPOSE 8080
