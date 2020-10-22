var oReq = new XMLHttpRequest();

oReq.addEventListener("load", reqListener);
oReq.open("GET", "https://a8cnf30t7l.execute-api.us-east-2.amazonaws.com/Prod/jokes");
oReq.send();


function reqListener() {
    var data = JSON.parse(this.responseText);
    var key = Object.keys(data)[0];
    var joke = data[key];
    document.getElementById('joke').innerHTML = joke;
}

function refresh() {
    oReq.addEventListener("load", reqListener);
    oReq.open("GET", "https://a8cnf30t7l.execute-api.us-east-2.amazonaws.com/Prod/jokes");
    oReq.send();
}




