$(document).on 'turbolinks:load', ->
  return unless page.controller() == 'users' && page.action() == 'myprofile'
  alert("Inside myProfile.cofffe");