// jokes.js

// Handle the request
function reqListener() {
  var data = JSON.parse(this.responseText);
  var key = Object.keys(data)[0];
  var joke = data[key];
  // Ensure the element exists before setting innerHTML
  const jokeElement = document.getElementById('joke');
  if (jokeElement) {
    jokeElement.innerHTML = joke;
  } else {
    console.error("Element with ID 'joke' not found");
  }
}

// FInitiate the joke API request
function getJoke() {
  var oReq = new XMLHttpRequest();
  oReq.addEventListener('load', reqListener);
  oReq.open(
    'GET',
    'https://a8cnf30t7l.execute-api.us-east-2.amazonaws.com/Prod/jokes'
  );
  oReq.send();
}

// Refresh the joke,
function refreshJoke() {
  getJoke();
}

// Export the functions so they can be used in index.js
export { refreshJoke };
