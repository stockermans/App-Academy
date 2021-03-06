/*
  Asynchronous javascript and xml
  Browser makes http request without throwing things away,
  responds with json
*/

$.ajax({
  method: 'POST',
  url: '/cats',
  dataType: 'json',
  data:  cat,
  success: function(response) {

  }
})

/* on rails side

render json: cat

*/

$.ajax({
  type: 'GET',
  url: "http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=bcb83c4b54aee8418983c2aff3073b3b",
  success(data) {
    console.log("We have your weather!")
    console.log(data);
  },
  error() {
    console.error("An error occurred.");
  },
});