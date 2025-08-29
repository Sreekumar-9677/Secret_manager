# Stage 1: Build Angular app
FROM node:20 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --configuration=production

# Stage 2: Nginx serve
FROM nginx:alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/dist/my-secret-app/browser ./

# Copy custom nginx config template
COPY nginx.conf /etc/nginx/conf.d/default.conf


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



