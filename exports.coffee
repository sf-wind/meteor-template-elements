BElements = {}

BElements.getParentTemplate = (tmpl, parentName) ->
  view = tmpl.view
  while (view isnt null) and
    (view isnt undefined) and
    ((view.templateInstance is undefined) or
      ((parentName isnt undefined) and
      (view.name isnt ("Template." + parentName))))

    view = view.parentView

  if view and view.templateInstance
    return view.templateInstance()
  else
    return undefined
