-- Define a Lua function to be called after sending the response
local function post_response()
    -- Log request data
    ngx.log(ngx.INFO, "Request URI: ", ngx.var.request_uri)
    ngx.log(ngx.INFO, "Request method: ", ngx.var.request_method)
    ngx.log(ngx.INFO, "Request headers: ", ngx.req.raw_header())

    -- Log response data
    ngx.log(ngx.INFO, "Response status: ", ngx.status)
    ngx.log(ngx.INFO, "Response headers: ", ngx.resp.get_headers())
end

-- Schedule a timer to call the post_response function after a delay of 0 seconds
local ok, err = ngx.timer.at(0, post_response)
if not ok then
    ngx.log(ngx.ERR, "Failed to create timer: ", err)
end