# Stage 1: Build the React app
FROM node:18-alpine AS build

WORKDIR /app

# Copy only package.json
COPY package.json ./

# Install dependencies
RUN npm install --silent

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Serve the app with Nginx
FROM nginx:stable-alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]