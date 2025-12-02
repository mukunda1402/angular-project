# Stage 1: Build Angular app
FROM public.ecr.aws/docker/library/node:20-alpine as build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build --prod

# Stage 2: Serve with Nginx
FROM public.ecr.aws/nginx/nginx:alpine

COPY --from=build /app/dist/my-angular-app /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
