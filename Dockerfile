# Stage 1: Build Angular app
FROM node:20 as build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build -- --configuration production

# Stage 2: Nginx to serve files
FROM nginx:alpine
COPY --from=build /app/dist/my-secret-app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
