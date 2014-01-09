window.disqus_shortname = 'sampierson'

class Sam.Disqus

  @embedCommentConversation: (thread_identifier) ->
    window.disqus_identifier = thread_identifier;
    dsq = document.createElement 'script'
    dsq.type = 'text/javascript'
    dsq.async = true
    dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js'
    document.getElementsByTagName('head')[0].appendChild(dsq)

  @setupCommentCountLinks: ->
    s = document.createElement 'script'
    s.async = true
    s.type = 'text/javascript'
    s.src = '//' + window.disqus_shortname + '.disqus.com/count.js'
    document.getElementsByTagName('HEAD')[0].appendChild(s)
