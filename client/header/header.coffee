if Meteor.isClient
  Template.BEHeaderInternal.events
    'click #be-back' : (e, tmpl) ->
      history.back()
    Template.BEHeaderInternal.helpers
      'back' : ->
        if typeof this.back is "string"
          this.back = {url : this.back}
        return this.back
      

if Meteor.isClient
  Template.BEHeaderOption.events
    'click a.be-header-link' : (e, tmpl) ->
      res = undefined
      if @action
        res = @action(e, tmpl)
        if res is false
          return false
      $('#navbar-collapsable').collapse('hide')
    'click a.dropdown-menu-item' : (e, tmpl) ->
      res = undefined
      if @action
        res = @action(e, tmpl)
        if res is false
          return false
      $('#navbar-collapsable').collapse('hide')
 
if Meteor.isClient
  Template.BEHeader.helpers
    'hasHeader' : ->
      if _.isEmpty this
        return false
      else
        return true
        
