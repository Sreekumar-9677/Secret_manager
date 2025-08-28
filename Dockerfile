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

# Copy Nginx template config (Cloud Run needs ${PORT})
COPY nginx.conf /etc/nginx/templates/default.conf.template

# Cloud Run will send traffic to port 8080
EXPOSE 8080
