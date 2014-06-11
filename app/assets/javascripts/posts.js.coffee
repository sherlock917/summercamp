# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'ready',() ->

  $('#post-submit').on 'click', () ->
    data = {
      title : $('#title').val(),
      content : $('#content').val(),
      cate : $('#cate').val(),
      url : 'url'
    }
    $.post('/posts', data)
    .success(successCallback)
    .fail(failCallback)
    return false

  successCallback = (data) ->
    location.reload()

  failCallback = (data) ->
    console.log data