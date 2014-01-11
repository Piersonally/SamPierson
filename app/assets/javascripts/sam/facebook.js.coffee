class Sam.Facebook

  @setupLikeButtons: ->
    scriptTag = 'script'
    facebookTagID = 'facebook-jssdk'

    fjs = document.getElementsByTagName(scriptTag)[0]
    protocol = if /^http:/.test(document.location) then 'http' else 'https'

    unless document.getElementById facebookTagID
      js = document.createElement scriptTag
      js.id = facebookTagID
      js.src = protocol + "://connect.facebook.net/en_US/all.js#xfbml=1&appId=1376037512657011"
      fjs.parentNode.insertBefore js, fjs
