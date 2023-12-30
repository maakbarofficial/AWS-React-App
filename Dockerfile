# Use an official Node runtime as a base image
FROM node:14-alpine as build

# Set the working directory to /app
WORKDIR /app

# Copy package.json and yarn.lock to the working directory
COPY package.json yarn.lock ./

# Install the app dependencies
RUN yarn install

# Copy the local files to the container
COPY . .

# Build the app
RUN yarn build

# Use a smaller image for serving
FROM nginx:alpine

# Copy the built artifacts to the serving image
COPY --from=build /app/dist /usr/share/nginx/html

# Expose the port the app will run on
EXPOSE 80

# Command to run the nginx server
CMD ["nginx", "-g", "daemon off;"]
