# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'ready',() ->

  $('#post-submit').on 'click', () ->
    if $('#post-attachment')[0].files.length > 0
      file = $('#post-attachment')[0].files[0]
      if uploadable(file.type, file.size)
        upload file
    else 
      createPost {
        title : $('#post-title').val(),
        content : $('#post-content').val(),
        cate : $('#post-cate').val()
      }
    false

  uploadable = (type, size) ->
    (type == 'application/x-rar' || 
    type == 'application/zip' ||
    type == 'image/jpeg' ||
    type == 'image/png' || 
    type == 'image/gif') &&
    (size < 50000000)

  upload = (file) ->
    token = $('meta[name="qiniu-token"]').attr 'content'
    fd = new FormData()
    fd.append 'file', file
    fd.append 'key', file.name
    fd.append 'token', token
    console.log 'start uploading'
    $.ajax
      url: 'http://up.qiniu.com',
      dataType: 'json',
      method: 'post',
      data: fd,
      contentType: false,
      processData: false,
      success : (data) ->
        createPost {
          title : $('#post-title').val(),
          content : $('#post-content').val(),
          cate : $('#post-cate').val(),
          attachment_name : file.name,
          attachment_url : 'http://scauhci.qiniudn.com/' + data.key
        }
      xhr : () ->
        xhr = $.ajaxSettings.xhr()
        xhr.upload.onprogress = (progress) ->
          percentage = Math.floor(progress.loaded / progress.total * 100)
          # console.log  percentage
        xhr

  createPost = (data) ->
    $.post('/posts', data)
    .success(postSuccessCallback)
    .fail(postFailCallback)

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