if Meteor.isClient
  Template.TECodeRemote.onRendered ->
    data = this.data
    if not data.id
      return
    template = this
    filename = (if data.filename then data.filename else data.id) + ".txt"
    dir = if data.dir then data.dir + '/' else '/code/'
    $.ajax
      url : dir + filename
      success : (res)->
        div = template.find('pre#' + data.id)
        $(div).text(res)
        if (typeof(hljs) is "function") and (not data.noHighlight)
          hljs.highlightBlock(div)
      error : (err)->
        console.log err
    return

if Meteor.isClient
  Template.TECodeLocal.onRendered ->
    data = this.data
    if (data isnt undefined) and
      (typeof(hljs) is "function") and
      (not data.noHighlight)
      div = this.find('pre')
      hljs.highlightBlock(div)
