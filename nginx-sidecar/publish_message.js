function publish_message(r) {
    console.log("Nginx Request object: " + r);
    console.log("Nginx Request object: " + JSON.stringify(r, null, 2));
    console.log("Request: " + r.request);
    console.log("Response: " + r.response);
    /*const request_data = {
        url: r.request.uri,
        method: r.request.method,
        headers: r.request.headersIn,
        body: r.request.body,
    };
    const response_data = {
        status: r.response.status,
        headers: r.response.headersOut,
        body: r.response.body,
    };

    if (request_data && response_data) {

        // Send combined data to upstream2 using HTTP POST
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "http://hello-world-service-example:8081/publish", true);  // Adjust URL if necessary
        xhr.setRequestHeader("Content-Type", "application/json");
        xhr.send(JSON.stringify(combined_data));
    }*/
}



export default { publish_message };
