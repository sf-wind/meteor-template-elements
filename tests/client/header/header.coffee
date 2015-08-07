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
        chai.expect(div.find('nav').length).to.equal(0)
    }
    {
      name : "Header : Helper, noBack"
      data : data.headerNoBack
      template : "TEHeader"
      test : (div)->
        chai.expect(div.find('.te-title-back').length).to.equal(1)
        # no options
        chai.expect(div.find('.navbar-toggle').length).to.equal(0)
        chai.expect(div.find('.navbar-collapse').length).to.equal(0)
    }
    {
      name : "Header : Helper, complete"
      data : data.headerComplete
      template : "TEHeader"
      test : (div)->
        chai.expect(div.find('#te-header-back').length).to.equal(1)
        # test Name
        chai.expect(div.find('.name-class').attr('href')).to.equal('/name/href')
        # test icon
        chai.expect(div.find('.icon-class').hasClass('class-icon')).to.be.true
        chai.expect(div.find('.icon-class').attr('href')).to.equal('/icon/href')
        chai.expect(div.find('.icon-class').find('.fa-icon').length).to.equal(1)
        # test menu icon
        chai.expect(div.find('.te-header-options').find('li.dropdown').find('.fa-icon').length).to.equal(1)
        chai.expect(div.find('#id-icon').find('.fa-menu-icon').length).to.equal(1)
        chai.expect(div.find('#menu-id-1').attr('href')).to.equal('menu/1/href')
        # test menu Name
        chai.expect(div.find('.te-one-header-option').find('.caret').parent().length).to.equal(1)

    }
    {
      name : "Header : Event, click name"
      data : data.headerComplete
      template : "TEHeader"
      before : (div)->
        div.find('.name-class').trigger('click')
      test : (div) ->
        chai.expect(Session.get('headerTest')).to.equal('nameOnly')
        Session.set('headerTest', undefined)
    }
    {
      name : "Header : Event, click icon"
      data : data.headerComplete
      template : "TEHeader"
      before : (div)->
        div.find('.icon-class').trigger('click')
      test : (div) ->
        chai.expect(Session.get('headerTest')).to.equal('iconOnly')
        Session.set('headerTest', undefined)
    }
    {
      name : "Header : Event, click dropdown menu"
      data : data.headerComplete
      template : "TEHeader"
      before : (div)->
        div.find('#menu-id-1').trigger('click')
      test : (div) ->
        chai.expect(Session.get('headerTest')).to.equal('dropdownMenuItem')
        Session.set('headerTest', undefined)
    }
  ]

tests.push headerTests
