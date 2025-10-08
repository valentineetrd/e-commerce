# Use the official Nginx image as a base
FROM nginx:alpine

# Set working directory inside the container
WORKDIR /usr/share/nginx/html

# Remove the default nginx website
RUN rm -rf ./*

# Copy your website files into the container
COPY . .

# Expose port 8085 for external access
EXPOSE 8085

# Replace the default nginx config to use port 8085
RUN sed -i 's/listen       80;/listen       8085;/' /etc/nginx/conf.d/default.conf

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
