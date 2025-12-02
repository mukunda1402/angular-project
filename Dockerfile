# Step 1: Build the Angular app
FROM public.ecr.aws/docker/library/node:20-alpine


WORKDIR /app


COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build --prod

# Step 2: Serve the built app using Nginx
FROM public.ecr.aws/nginx/nginx:alpine

COPY --from=build /app/dist/my-angular-app /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
