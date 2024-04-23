FROM nginx:latest

# Copy Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose ports if needed
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]