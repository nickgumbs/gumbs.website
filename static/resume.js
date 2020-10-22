function reqListener() {
    var data = JSON.parse(this.responseText);
    console.log(data);

    var count = data["gumbs.website"];
    
    document.getElementById('count').innerHTML = 'Site Visitor Count: ' + count;
}

var oReq = new XMLHttpRequest();
oReq.addEventListener("load", reqListener);
oReq.open("GET", "https://ydemw5gqe7.execute-api.us-east-2.amazonaws.com/Prod/visit");
oReq.send();