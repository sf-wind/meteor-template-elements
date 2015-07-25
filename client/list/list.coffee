if Meteor.isClient
  Template.BEList.events
    'click table' : (e, tmpl) ->
      $target = $(e.target)
      data = this
      $panel = $target.closest('.panel')
      if $panel.length == 0
        return
      type = $panel.attr('id')
      if !type
        return

      items = data.items
      if !items
        return
      $tr = $target.closest('tr')
      id = $tr.attr('id')
      if !id
        return
      item = _.find items, (t) ->
        t.id == id
      if !item
        return

      action = undefined
      $a = $target.closest('a.icon')
      if $a.length == 0
        # the main body
        $a = $target.closest('a.be-list-content')
        if $a.length == 0
          return
        if item.action
          action = item.action
        else
          if data.action
            action = data.action
      else
        # click an icon
        index = $a.closest('td').index()
        cell = item?.cells?[index]
        icons = cell?.icons
        icon = undefined
        for ic in icons
          if $a.hasClass('class-'+ic.icon)
            icon = ic
            break
        if icon
          action = icon.action
      if _.isFunction action
        res = action(e, tmpl, $tr, $a)
        if res is false
          return false

if Meteor.isClient
  Template.BEList.helpers
    'items' : ->
      items = this?.items
      if items?.length > 0
        for i in [0...items.length]
          item = items[i]
          if i is 0 
            item.class = if item.class then item.class + " be-first-item" else "be-first-item"
          if i is items.length-1
            item.class = if item.class then item.class + " be-last-item" else "be-last-item"
            
          cells = item?.cells
          if cells?.length > 0
            for j in [0...cells.length]
              cell = cells[j]
              if cell.title or cell.description
                cell.hasContent = true
              if j is 0
                cell.class = if cell.class then cell.class + " be-first-cell" else "be-first-cell"
              if j is cells.length-1
                cell.class = if cell.class then cell.class + " be-last-cell" else "be-last-cell"
          else if item.title or item.description
            cell = {
              title : item.title
              description : item.description
              titleClass : item.titleClass
              descriptionClass : item.descriptionClass
              href : item.href
              hasContent : true
            }
            item.cells = [cell]
            delete item.title
            delete item.description
            delete item.titleClass
            delete item.descriptionClass
            delete item.href
        return items
    'hasItems' : ->
      if this?.items
        return true
      else
        return false
  Template.BEPagination.helpers
    'pages' : ->
      total = this.total
      page_number = this.page_number
      items_per_page = this.items_per_page
      num_pager = if this.num_pager then num_pager else 5
      num_pages = Math.ceil(total / items_per_page)
      action = this.action
      getHREF = this.getHREF
      paginationAction = this.paginationAction
      pages = []
      # previous
      pages.push
        aclass : "page-" + Math.max(1, page_number)
        aria_label : "Previous"
        aria_hidden : "«"
        class : if page_number is 0 then "disabled" else undefined
        href : if getHREF then getHREF(Math.max(0, page_number-1)) else undefined
        paginationAction : if paginationAction then paginationAction(Math.max(0, page_number-1)) else undefined
      from = Math.max(0, page_number-2)
      to = Math.min(from + num_pager, num_pages)
      for i in [from...to]
        pages.push
          aclass : "page-" + (i+1)
          class : if page_number is i then "active" else undefined
          page : i+1
          href : if getHREF then getHREF(i) else undefined
          paginationAction : if paginationAction then paginationAction(i) else undefined
      # next
      pages.push
        aclass : "page-" + Math.min(num_pages, page_number+1)
        class : if page_number is num_pages-1 then "disabled" else undefined
        aria_label : "Next"
        aria_hidden : "»"
        href : if getHREF then getHREF(Math.min(num_pages-1, page_number+1)) else undefined
        paginationAction : if paginationAction then paginationAction(Math.min(num_pages-1, page_number+1)) else undefined    
      pages
  Template.BEOnePageItem.events
    'click a' : ->
      if this.paginationAction
        this.paginationAction()
  
