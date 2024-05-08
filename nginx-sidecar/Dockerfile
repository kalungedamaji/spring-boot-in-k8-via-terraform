# Base image
FROM ubuntu:latest AS base

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    build-essential \
    libpcre3-dev \
    zlib1g-dev \
    libssl-dev \
    perl \
    libxml2-dev \
    libxslt-dev \
 && rm -rf /var/lib/apt/lists/*

# Download NGINX source (version 1.9.5)
RUN wget https://nginx.org/download/nginx-1.9.5.tar.gz \
 && tar -xzvf nginx-1.9.5.tar.gz \
 && rm nginx-1.9.5.tar.gz

# Download latest njs source (adjust URL if needed)
RUN wget https://github.com/nginx/njs/archive/refs/heads/master.tar.gz \
 && tar -xzvf master.tar.gz \
 && mv njs-master nginx-1.9.5/njs \
 && rm master.tar.gz

# Build NGINX with the JavaScript module
WORKDIR /nginx-1.9.5
RUN ./configure --add-module=../njs/nginx/nginx \
 && make \
 && make install

# Cleanup
RUN rm -rf /nginx-1.9.5 /njs

# Copy NGINX configuration to enable JavaScript module
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
