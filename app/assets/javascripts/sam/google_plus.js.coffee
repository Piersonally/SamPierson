class Sam.GooglePlus

  @setupPlusButtons: ->
    po = document.createElement 'script'
    po.type = 'text/javascript'
    po.async = true
    po.src = 'https://apis.google.com/js/platform.js'
    s = document.getElementsByTagName('script')[0]
    s.parentNode.insertBefore po, s
