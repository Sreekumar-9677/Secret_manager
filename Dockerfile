# Stage 1: Build Angular App
FROM node:20 as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod

# Stage 2: Serve App with NGINX
FROM nginx:alpine
COPY --from=builder /app/dist/my-secret-app /usr/share/nginx/html

# Replace default nginx config with one that listens on Cloud Run's PORT
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Cloud Run requires listening on $PORT
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
