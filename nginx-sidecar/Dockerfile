# Use the official OpenResty image
FROM openresty/openresty:alpine

# Install LuaRocks dependencies and OpenSSL for checksum calculation
RUN apk --no-cache add curl perl make gcc g++ unzip openssl

# Download and install LuaRocks
RUN curl -L https://luarocks.org/releases/luarocks-3.7.0.tar.gz | tar xz \
    && cd luarocks-3.7.0 \
    && ./configure \
    && make build \
    && make install \
    && cd .. \
    && rm -rf luarocks-3.7.0

# Install LuaRocks packages
RUN luarocks install lua-resty-http
RUN luarocks install lua-resty-openssl

# Copy NGINX configuration file with Lua block
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

# Expose port 80
EXPOSE 80

# Start NGINX server
CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
