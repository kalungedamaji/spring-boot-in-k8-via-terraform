
function capture_resp_send_client_sqs(res, data, flags) {
    console.log("Nginx Request object: " + JSON.stringify(res, null, 2));
    var response_body_arr = new Array();
    response_body_arr.push(data);
    console.log("Response body: "+JSON.stringify(response_body_arr.join('')));
    res.sendBuffer(data, flags);
    console.log(" sending message to Queue")

}
export default { capture_resp_send_client_sqs };
