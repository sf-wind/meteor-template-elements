@UTIL =
  getParentTemplate : (tmpl) ->
    view = tmpl.view?.parentView
    while (view isnt (null and undefined)) and (view.templateInstance is undefined)
      view = view.parentView

    if view and view.templateInstance
      return view.templateInstance()
    else
      return undefined
