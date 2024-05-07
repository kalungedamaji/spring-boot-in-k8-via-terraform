# Base image
FROM nginx:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    build-essential \
    libpcre3-dev \
    zlib1g-dev \
    libssl-dev \
    gnupg \
    perl \
    libxml2-dev \
    libxslt-dev \
 && rm -rf /var/lib/apt/lists/*

# Download NGINX source (specific version)
RUN wget https://nginx.org/download/nginx-1.23.2.tar.gz \
 && tar -xzvf nginx-1.23.2.tar.gz \
 && rm nginx-1.23.2.tar.gz

# Download latest njs source (adjust URL if needed)
RUN wget https://github.com/nginx/njs/archive/refs/heads/master.tar.gz \
 && tar -xzvf master.tar.gz \
 && mv njs-master njs \
 && rm master.tar.gz

# Build NGINX with the JavaScript module
RUN cd nginx-1.23.2 \
 && ./configure --with-compat --add-dynamic-module=../njs/nginx \
 && make \
 && make install

# Cleanup
RUN rm -rf /nginx-1.23.2 /njs

# Copy NGINX configuration to enable JavaScript module
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the JavaScript file
COPY publish_message.js /etc/nginx/publish_message.js
# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
