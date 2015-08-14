if Meteor.isClient
  Template.TEPagination.helpers
    'hasPages' : ->
      return @total isnt undefined
    'pages' : ->
      total = @total
      page_number = @page_number
      items_per_page = @items_per_page
      num_pager = if @num_pager then @num_pager else 5
      num_pages = Math.ceil(total / items_per_page)
      getHREF = @getHREF
      pages = []
      # previous
      prev_idx = Math.max(1, page_number-1)
      pages.push
        aclass : "te-page-" + prev_idx + " te-page-previous"
        aria_label : "Previous"
        aria_hidden : "«"
        class : if page_number is 1 then "disabled" else undefined
        href : if getHREF then getHREF(prev_idx) else undefined
        index : prev_idx
      from = Math.min(Math.max(1, page_number-Math.floor((num_pager)/2)), num_pages-num_pager + 1)
      to = Math.min(from + num_pager-1, num_pages)
      for i in [from..to]
        pages.push
          aclass : "te-page-" + i
          class : if page_number is i then "active" else undefined
          page : i
          index : i
          href : if getHREF then getHREF(i) else undefined
      # next
      next_idx = Math.min(num_pages, page_number+1)
      pages.push
        aclass : "te-page-" + next_idx + " te-page-next"
        class : if page_number is num_pages then "disabled" else undefined
        aria_label : "Next"
        aria_hidden : "»"
        index : next_idx
        href : if getHREF then getHREF(next_idx) else undefined
      pages

  Template.TEPagination.events
    'click .te-nav-pagination' : (e, tmpl)->
      if @action
        $a = $(e.target).closest('a.te-pagination')
        index = $a.attr('index')
        if not index
          return
        idx = parseInt index
        if isNaN idx
          return
        # check disabled
        $li = $a.parent()
        if ($li.hasClass('disabled'))
          return
        template = UTIL.getParentTemplate(tmpl)
        res = @action(e, template, idx)
        if res is false
          return false
