if Meteor.isClient
  Template.TEList.events
    'click table' : (e, tmpl) ->
      $target = $(e.target)
      data = this
      $list = $target.closest('.te-table')
      if $list.length == 0
        return

      items = data.items
      if !items
        return
      $tr = $target.closest('tr')
      item_idx = parseInt $tr.attr('item')
      if isNaN item_idx
        return
      item = items[item_idx]

      if !item
        return

      action = undefined
      index = $target.closest('td').index()
      cell = item?.cells?[index]
      $a = $target.closest('a.icon')
      if $a.length != 0
        # click an icon
        icons = cell?.icons
        icon = undefined
        for ic in icons
          if $a.hasClass('class-'+ic.icon)
            icon = ic
            break
        if icon
          action = icon.action
      if not action
        # the main body
        $a = $target.closest('.te-table-cell')
        if $a.length isnt 0
          if cell?.action
            action = cell.action
      if not action
        $a = $target.closest('.te-table-row')
        if $a.length isnt 0
          if item?.action
            action = item.action
      if not action
        if data.action
          action = data.action

      if _.isFunction action
        template = UTIL.getParentTemplate(tmpl)
        res = action(e, template, $tr, $a)
        if res is false
          return false

formatName = (field)->
  type = typeof field
  fld = undefined
  if type is "string"
    fld =
      name : field
  else if type is "object"
    fld =
      name : field.name
      class : field.class
  fld


if Meteor.isClient
  Template.TEList.helpers
    'items' : ->
      items = this?.items
      if items?.length > 0
        max_num_cells = 0
        row_num_cells = []
        for i in [0...items.length]
          item = items[i]
          item.item = i
          num_cells = 0
          cells = item?.cells
          if cells?.length > 0
            for j in [0...cells.length]
              num_cols = 1
              cell = cells[j]
              if cell.colspan
                num_cols = parseInt cell.colspan
              num_cells += num_cols
              if cell.title or cell.description
                cell.hasContent = true
                cell.title = formatName cell.title
                cell.description = formatName cell.description
          else if item.title or item.description
            cell =
              title : formatName item.title
              description : formatName item.description
              href : item.href
              hasContent : true
            num_cells = 1
            item.cells = [cell]
            delete item.title
            delete item.description
            delete item.href
            if item.icons
              cell =
                icons : item.icons
              num_cells++
              item.cells.push cell
              delete item.icons
          else
            item.cells = [{}]
            num_cells = 1
          max_num_cells = Math.max(max_num_cells, num_cells)
          row_num_cells.push num_cells

        for i in [0...items.length]
          item = items[i]
          num_cells = row_num_cells[i]

          last_cell = item.cells[item.cells.length-1]
          if num_cells < max_num_cells
            if last_cell.colspan
              last_cell.colspan = last_cell.colspan + max_num_cells - num_cells
            else
              last_cell.colspan = max_num_cells - num_cells + 1
          if item.cells[0].class is undefined
            item.cells[0].class = "te-first-cell"
          else if item.cells[0].class.indexOf('te-first-cell') < 0
            item.cells[0].class = item.cells[0].class + " te-first-cell"

          if last_cell.class is undefined
            last_cell.class = "te-last-cell"
          else if last_cell.class.indexOf('te-last-cell') < 0
            last_cell.class =  last_cell.class + " te-last-cell"

        if items[0].class is undefined
          items[0].class = "te-first-item"
        else if items[0].class.indexOf('te-first-item') < 0
          items[0].class = items[0].class + " te-first-item"

        last_item = items[items.length-1]
        if last_item.class is undefined
          last_item.class = "te-last-item"
        else if last_item.class.indexOf('te-last-item') < 0
          last_item.class = last_item.class + " te-last-item"

        items
    'hasItems' : ->
      if this?.items
        return true
      else
        return false
