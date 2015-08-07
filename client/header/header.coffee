if Meteor.isClient
  Template.TEHeader.events
    'click #te-header-back' : (e, tmpl) ->
      history.back()

if Meteor.isClient
  Template.TEHeader.helpers
    'hasHeader' : ->
      if _.isEmpty this
        return false
      else
        return true

if Meteor.isClient
  Template.TEHeaderOption.events
    'click a.te-header-link' : (e, tmpl) ->
      res = undefined
      if @action
        res = @action(e, tmpl)
        if res is false
          return false
      if typeof $.fn.collapse is "function"
        $('#navbar-collapsable').collapse('hide')
    'click a.dropdown-menu-item' : (e, tmpl) ->
      res = undefined
      if @action
        res = @action(e, tmpl)
        if res is false
          return false
      if typeof $.fn.collapse is "function"
        $('#navbar-collapsable').collapse('hide')
