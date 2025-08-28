FROM node:20 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --configuration=production

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist/my-secret-app/browser .
# Put the template where the nginx entrypoint expects it:
COPY nginx.conf /etc/nginx/templates/default.conf.template
EXPOSE 8080
# Do NOT override CMD; the nginx official entrypoint will envsubst this template automatically.
