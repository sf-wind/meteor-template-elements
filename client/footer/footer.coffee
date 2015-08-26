if Meteor.isClient
  Template.TEFooter.events
    'click a.te-footer-item' : (e, tmpl)->
      if @action
        template = BElements.getParentTemplate(tmpl)
        res = @action(e, template)
        if res is false
          return false
  Template.TEFooter.helpers
    'hasFooter' : ->
      not _.isEmpty this
    'isFixed' : ->
      not this?.isInline is true
    'items' : ->
      items = this.items
      num = Math.max(1, Math.min(12, items.length))
      grid = Math.floor(12 / num)
      for item in items
        item.grid = grid
        if item.active is true
          item.active = "active"
        else
          item.active = undefined
      items
