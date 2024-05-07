var request;
var requestObj;
function cap_req(req) {
    console.log("Nginx Request object: " + req);
    console.log("Nginx Request object: " + JSON.stringify(req, null, 2));

    console.log("ngx object:", JSON.stringify(ngx));
    requestObj=req;
    //request = JSON.parse(ngx.var.request_object);
    console.log("ngx: " + ngx.location);
    console.log(" ngx.location: " + ngx.location);
    console.log("req.ngx: " + req.ngx);
    console.log("req.uri: " + req.uri);


    // Return undefined to continue with the original response
    return undefined;

}
function publish_message(res) {
    console.log("Nginx Response object: " + res);
    console.log("Nginx Response object: " + JSON.stringify(res, null, 2));
    console.log("requestObj: " + requestObj);
    console.log("request: " + request);

    return undefined;

}



export default { cap_req,publish_message };
