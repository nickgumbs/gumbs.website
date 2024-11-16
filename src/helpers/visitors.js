// visitors.js

// Handle the request
function reqListener() {
    var data = JSON.parse(this.responseText);
    var count = data["gumbs.website"];
    
    document.getElementById('count').innerHTML = 'Site Visitor Count: ' + count;
}

// FInitiate the joke API request
function refreshCount() {
    var oReq = new XMLHttpRequest();
    oReq.addEventListener("load", reqListener);
    oReq.open("GET", "https://ydemw5gqe7.execute-api.us-east-2.amazonaws.com/Prod/visit");
    oReq.send();
}

// Export the functions so they can be used in index.js
export { refreshCount };




