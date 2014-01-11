class Sam.Twitter

  @setupTweetButtons: ->
    scriptTag = 'script'
    twitterTagID = 'twitter-wjs'

    fjs = document.getElementsByTagName(scriptTag)[0]
    protocol = if /^http:/.test(document.location) then 'http' else 'https'

    unless document.getElementById(twitterTagID)
      js = document.createElement(scriptTag)
      js.id = twitterTagID
      js.src = protocol + '://platform.twitter.com/widgets.js'
      fjs.parentNode.insertBefore js, fjs
