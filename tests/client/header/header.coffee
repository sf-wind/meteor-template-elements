data =
  headerComplete :
    options : [
      {
        name : "Name only"
        class : "name-class"
        href : "/name/href"
        action : ->
          Session.set('headerTest', "nameOnly")
      }
      {
        icon : "icon"
        class : "icon-class"
        href : "/icon/href"
        action : ->
          Session.set('headerTest', "iconOnly")
      }
      {
        icon : "icon"
        id : "id-icon"
        items : [
          {
            id : "menu-id-1"
            icon : "menu-icon"
            name : "menu-name"
            href : "menu/1/href"
            action : ->
              Session.set('headerTest', 'dropdownMenuItem')
          }
          {
            id : "menu-id-2"
            icon : "menu-icon2"
            name : "menu-name2"
          }
        ]
      }
      {
        name : "dropdown-name"
        items : [
          {
            name : "menu-name"
          }
        ]
      }
    ]
  headerNoBack :
    noBack : true

headerTests =
  name : "Test header element"
  tests : [
    {
      name : "Header : Helper, empty"
      data : undefined
      template : "TEHeader"
      test : (div)->
        expect(div.find('nav').length).toEqual(0)
    }
    {
      name : "Header : Helper, noBack"
      data : data.headerNoBack
      template : "TEHeader"
      test : (div)->
        expect(div.find('.te-title-back').length).toEqual(1)
        # no options
        expect(div.find('.navbar-toggle').length).toEqual(0)
        expect(div.find('.navbar-collapse').length).toEqual(0)
    }
    {
      name : "Header : Helper, complete"
      data : data.headerComplete
      template : "TEHeader"
      test : (div)->
        expect(div.find('#te-header-back').length).toEqual(1)
        # test Name
        expect(div.find('.name-class').attr('href')).toEqual('/name/href')
        # test icon
        expect(div.find('.icon-class').hasClass('class-icon')).toBe(true)
        expect(div.find('.icon-class').attr('href')).toEqual('/icon/href')
        expect(div.find('.icon-class').find('.fa-icon').length).toEqual(1)
        # test menu icon
        expect(div.find('.te-header-options').find('li.dropdown').find('.fa-icon').length).toEqual(1)
        expect(div.find('#id-icon').find('.fa-menu-icon').length).toEqual(1)
        expect(div.find('#menu-id-1').attr('href')).toEqual('menu/1/href')
        # test menu Name
        expect(div.find('.te-one-header-option').find('.caret').parent().length).toEqual(1)

    }
    {
      name : "Header : Event, click name"
      data : data.headerComplete
      template : "TEHeader"
      before : (div)->
        div.find('.name-class').trigger('click')
      test : (div) ->
        expect(Session.get('headerTest')).toEqual('nameOnly')
        Session.set('headerTest', undefined)
    }
    {
      name : "Header : Event, click icon"
      data : data.headerComplete
      template : "TEHeader"
      before : (div)->
        div.find('.icon-class').trigger('click')
      test : (div) ->
        expect(Session.get('headerTest')).toEqual('iconOnly')
        Session.set('headerTest', undefined)
    }
    {
      name : "Header : Event, click dropdown menu"
      data : data.headerComplete
      template : "TEHeader"
      before : (div)->
        div.find('#menu-id-1').trigger('click')
      test : (div) ->
        expect(Session.get('headerTest')).toEqual('dropdownMenuItem')
        Session.set('headerTest', undefined)
    }
  ]

tests.push headerTests
