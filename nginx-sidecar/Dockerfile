FROM fabiocicerchia/nginx-lua

RUN apk update && \
    apk add --no-cache git gcc expat-dev libc-dev && \
    rm -rf /var/cache/apk/*

RUN apk add --no-cache lua lua-socket lua-sec luarocks
RUN luarocks install lua-zlib

RUN luarocks install lua-resty-aws


COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./send_to_sqs.lua /etc/nginx/send_to_sqs.lua


# Expose ports if needed
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]