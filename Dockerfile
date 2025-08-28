# Stage 1: Build Angular App
FROM node:20 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --configuration=production

# Stage 2: Serve App with NGINX
FROM nginx:alpine
COPY --from=builder /app/dist/my-secret-app/browser /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

# ✅ Added this line so Cloud Run knows which port to listen on
EXPOSE 8080  

# ✅ Added this CMD to make sure nginx runs in foreground
CMD ["nginx", "-g", "daemon off;"]


