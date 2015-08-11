if Meteor.isClient
  Template.TEHeader.helpers
    'hasHeader' : ->
      if _.isEmpty this
        return false
      else
        return true
    'isFixed' : ->
      not this?.isInline is true


if Meteor.isClient
  Template.TEHeader.events
    'click .te-header-back' : (e, tmpl) ->
      history.back()
  Template.TEHeader.events
    'click a.te-header-link' : (e, tmpl) ->
      res = undefined
      if typeof $.fn.collapse is "function"
        div = tmpl.find('.navbar-collapse')
        if div
          $(div).collapse('hide')
      if @action
        # get calling template
        template = tmpl.view.parentView.parentView?.templateInstance()
        res = @action(e, template)
        if res is false
          return false

    'click a.dropdown-menu-item' : (e, tmpl) ->
      res = undefined
      if typeof $.fn.collapse is "function"
        div = tmpl.find('.navbar-collapse')
        if div
          $(div).collapse('hide')
      if @action
        template = tmpl.view.parentView.parentView?.templateInstance()
        res = @action(e, template)
        if res is false
          if typeof $.fn.dropdown is "function"
            div = $(e.target).closest('.dropdown')
            if div
              a = $('a.dropdown-toggle', $(div))
              if (a.length > 0)
                a.dropdown('toggle')
          return false
