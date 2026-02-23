// visitors.js

// Handle the request
function reqListener() {
  var data = JSON.parse(this.responseText);
  var count = data['gumbs.me'];

  document.getElementById('count').innerHTML = 'Site Visitor Count: ' + count;
}

// FInitiate the joke API request
function refreshCount() {
  if (!window.APP_CONFIG?.api?.base_url) return;
  var oReq = new XMLHttpRequest();
  oReq.addEventListener('load', reqListener);
  oReq.open('GET', window.APP_CONFIG.api.base_url + '/visit');
  oReq.send();
}

// Export the functions so they can be used in index.js
export { refreshCount };
