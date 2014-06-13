# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'ready',() ->

  $('.post-attachment').on 'change', () ->
    fileChangeHandler (this)

  fileChangeHandler = (that) ->
    file = $(that)[0].files[0]
    if uploadable(file.type, file.size)
      length = $('.post-attachment').length
      last = $('.post-attachment')[length - 1]
      num = parseInt $(last).attr('id').split('-').pop()
      if num < 3
        $('#post-attachment-' + num)
        .clone()
        .attr('id', 'post-attachment-' + (num + 1))
        .insertAfter($(that))
        .on 'change', () ->
          fileChangeHandler (this)
    else
      $(that).val('')
      alert 'cant upload this file'

  $('#post-submit').on 'click', () ->
    if $('#post-attachment-1').val() == ''
      createPost
        title : $('#post-title').val(),
        content : $('#post-content').val(),
        cate : $('#post-cate').val()
    else
      valid = 0
      attachments = []
      for input in $('.post-attachment')
        file = $(input)[0].files[0]
        if file
          valid++
          upload file, (data) ->
            attachments.push data.key
            if attachments.length == valid
              createPost
                title : $('#post-title').val(),
                content : $('#post-content').val(),
                cate : $('#post-cate').val()
                attachments : attachments,
    false

  isImage = (type) ->
    type == 'image/jpeg' ||
    type == 'image/png' || 
    type == 'image/gif'

  uploadable = (type, size) ->
    (type == 'application/x-rar' || 
    type == 'application/zip' ||
    type == 'image/jpeg' ||
    type == 'image/png' || 
    type == 'image/gif') &&
    (size < 50000000)

  upload = (file, callback) ->
    token = $('meta[name="qiniu-token"]').attr 'content'
    fd = new FormData()
    fd.append 'file', file
    fd.append 'key', file.name
    fd.append 'token', token
    $.ajax
      url: 'http://up.qiniu.com',
      dataType: 'json',
      method: 'post',
      data: fd,
      contentType: false,
      processData: false,
      success : callback,
        # createPost {
        #   title : $('#post-title').val(),
        #   content : $('#post-content').val(),
        #   cate : $('#post-cate').val(),
        #   attachment_name : file.name,
        #   attachment_url : 'http://scauhci.qiniudn.com/' + data.key
        # }
      xhr : () ->
        xhr = $.ajaxSettings.xhr()
        xhr.upload.onprogress = (progress) ->
          percentage = Math.floor(progress.loaded / progress.total * 100)
          console.log  percentage
        xhr

  # uploadSuccessCallback = (data) ->
    # console.log data
    # finished++
    # attachments += 'http://scauhci.qiniudn.com/' + data.key + ''
    # console.log finished
    # console.log attachments

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