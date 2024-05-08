var response_body_arr = new Array();
function capture_resp_send_client_sqs(res, data, flags) {
    console.log("Inside script ");
    if (flags.last) {
        console.log("Nginx Request object: " + JSON.stringify(res, null, 2));
        response_body_arr.push(data);
        console.log("Response body: " + JSON.stringify(response_body_arr.join('')));
        res.sendBuffer(data, flags);
        console.log(" sending message to Queue")
        send_message_to_sqs(response_body_arr).then(function(sqsResponse) {
            console.log("SQS message sent successfully:", sqsResponse);
            // Potentially handle successful SQS interaction
        }).catch(function(error) {
            console.error('Error sending message to SQS:', error);
        });
        response_body_arr = [];
    }
}

function send_message_to_sqs(messageBody) {
    return new Promise(function(resolve, reject) {
        console.log("Inside send_message_to_sqs");

        // AWS SQS endpoint
        var sqsEndpoint = 'https://sqs.eu-west-1.amazonaws.com/755104603888/audit-events.fifo'+
            '?AWSAccessKeyId=ASIA27T5533YBUQXHK76&SecretAccessKey=gciXo1CWWaF/hvy+Ycu7CGrC6MuDE+venb0JYX8H';;
        // AWS IAM role for access (assuming you're running on EC2 instance with proper IAM role attached)

        // Convert the message to JSON
        var messageJson = JSON.stringify(messageBody);

        // Define request body
        var requestBody = 'Action=SendMessage&MessageBody=' + encodeURIComponent(messageJson) +
            '&MessageGroupId=audit-events&MessageDeduplicationId=' + Date.now();

        // Define request options
        var options = {
            method: 'POST',
            body: requestBody,
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'Content-Length': Buffer.byteLength(requestBody)
            }
        };

        // Make HTTP request to SQS using ngx.fetch
        ngx.fetch(sqsEndpoint, options).then(function(response) {
            if (response.status == 200) {
                console.log('Message sent to SQS. Response:', response.text());
                resolve();
            } else {
                reject('Error sending message to SQS. Status: ' + response.status + ', Body: ' + response.text());
            }
        }).catch(function(error) {
            reject('Error sending message to SQS:', error);
        });
    });
}
export default { capture_resp_send_client_sqs };
