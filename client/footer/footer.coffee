
if Meteor.isClient
  Template.BEFooter.events
    'click a.be-footer-item' : (e, tmpl)->
      if @action
        res = @action(e, tmpl)
        if res is false
          return false
  Template.BEFooter.helpers
    'hasFooter' : ->
      data = this
      this isnt undefined
