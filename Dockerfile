# tahap 0 - Build frontend web app
FROM node:14.17.6-alpine as build

WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

# tahap 1 - webserver frontend web app
FROM fholzer/nginx-brotli:v1.12.2

WORKDIR /etc/nginx
ADD nginx.conf /etc/nginx/nginx.conf

COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]

