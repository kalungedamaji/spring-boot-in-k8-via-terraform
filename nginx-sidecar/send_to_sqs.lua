local AWS = require "resty.aws"
local SQS = AWS.SQS
local sts = AWS.STS

-- Initialize SQS client
local sqs = SQS.new({
    accessKeyId = "<your_access_key_id>",
    secretAccessKey = "<your_secret_access_key>",
    region = "<your_aws_region>"
})

-- Define the SQS queue URL
local queue_url = "https://sqs.<your_aws_region>.amazonaws.com/<your_account_id>/<your_queue_name>"

-- Function to send message to SQS queue
local function send_to_sqs(message)
     ngx.log(ngx.ERR, " publish message to SQS: ", message)
    if not res then
        ngx.log(ngx.ERR, "Failed to send message to SQS queue: ", err)
    end
end

-- Capture request and response and send them to SQS queue
local request_body = ngx.req.get_body_data()
local response_body = ngx.arg[1]

local message = string.format("Request: %s | Response: %s", request_body, response_body)
ngx.log(ngx.INFO, "message")
send_to_sqs(message)
