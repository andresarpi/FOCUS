
$( document ).on('turbolinks:load', function() {
  if (!(page.controller() == 'users') && (page.action() == 'myprofile')) {
    return;
  }
})

var fetch_user_surveys_ajax = function() {
  
}