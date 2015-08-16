if Meteor.isClient
  Template.TECodeRemote.onRendered ->
    data = this.data
    template = this
    filename = (if data.filename then data.filename else if data.id then data.id + ".txt" else "code.txt")
    dir = if data.dir then data.dir + '/' else '/code/'
    $.ajax
      url : dir + filename
      success : (res)->
        div = template.find('pre')
        if div
          $(div).text(res)
          if (typeof(hljs) is "object") and (not data.noHighlight)
            if typeof (hljs.highlightBlock) is "function"
              hljs.highlightBlock(div)
      error : (err)->
        console.log err
    return

if Meteor.isClient
  Template.TECodeLocal.onRendered ->
    data = this.data
    if (data isnt undefined) and (typeof(hljs) is "object") and (not data.noHighlight)
      div = this.find('pre')
      if typeof (hljs.highlightBlock) is "function"
        hljs.highlightBlock(div)
