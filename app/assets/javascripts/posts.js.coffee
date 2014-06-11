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
    .success(postSuccessCallback)
    .fail(postFailCallback)
    false

  postSuccessCallback = (data) ->
    location.reload()

  postFailCallback = (data) ->
    console.log data

  $('#comment-submit').on 'click', () ->
    data = {
      post_id : location.href.split('/').pop(),
      content : $('#comment-content').val()
    }
    $.post('/comments', data)
    .success(commentSuccessCallback)
    .fail(commentFailCallback)
    false

  commentSuccessCallback = (data) ->
    location.reload()

  commentFailCallback = (data) ->
    console.log data