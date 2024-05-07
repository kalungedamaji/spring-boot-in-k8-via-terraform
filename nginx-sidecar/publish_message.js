var response_body_arr = new Array();
function capture_resp_send_client_sqs(res, data, flags) {
    console.log("Inside script ");
    if (flags.last) {
        console.log("Nginx Request object: " + JSON.stringify(res, null, 2));
        response_body_arr.push(data);
        console.log("Response body: " + JSON.stringify(response_body_arr.join('')));
        res.sendBuffer(data, flags);
        console.log(" sending message to Queue")
        response_body_arr.length = 0;
    }
    response_body_arr.push(data);
    res.sendBuffer(data, flags);


}
export default { capture_resp_send_client_sqs };
