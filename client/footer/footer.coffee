
if Meteor.isClient
  Template.TEFooter.events
    'click a.te-footer-item' : (e, tmpl)->
      if @action
        res = @action(e, tmpl)
        if res is false
          return false
  Template.TEFooter.helpers
    'hasFooter' : ->
      not _.isEmpty this
    'items' : ->
      items = this.items
      num = Math.max(1, Math.min(12, items.length))
      grid = Math.floor(12 / num)
      for item in items
        item.grid = grid
        if item.active is true
          item.active = "active"
      items
