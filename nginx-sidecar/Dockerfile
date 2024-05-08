# Base image (consider using a minimal image like alpine)
FROM nginx:alpine AS base

# Remove existing Nginx binary
RUN rm -rf /etc/nginx

# Download and extract NGINX source (version 1.9.5)
RUN wget https://nginx.org/download/nginx-1.9.5.tar.gz && \
    tar -xzvf nginx-1.9.5.tar.gz && \
    rm nginx-1.9.5.tar.gz

# Download compatible njs source (adjust URL for specific version)
RUN wget https://nginx.org/download/njs/njs-0.5.0.tar.gz && \
    tar -xzvf njs-0.5.0.tar.gz && \
    mv njs-0.5.0 nginx-1.9.5/njs && \
    rm njs-0.5.0.tar.gz

# Handle potential directory structure changes in njs
RUN mv nginx-1.9.5/njs/nginx/conf/nginx.conf nginx-1.9.5/njs/config/nginx.conf

# Install build dependencies (adjust based on your chosen base image)
RUN apk add --no-cache build-base zlib-dev pcre-dev openssl-dev perl libxml2-dev libxslt-dev

# Build stage
FROM base AS builder

# Copy NGINX configuration to enable JavaScript module
COPY nginx.conf /etc/nginx/nginx.conf

# Build NGINX with the JavaScript module
WORKDIR /nginx-1.9.5
RUN ./configure --add-module=../njs/nginx && make && make install

# Final image (consider a multi-stage build for reduced size)
FROM nginx:alpine AS final

# Copy the JavaScript file
COPY publish_message.js /etc/nginx/publish_message.js

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
