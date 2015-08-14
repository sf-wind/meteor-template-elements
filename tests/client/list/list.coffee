
data =
  listComplete :
    id : "list-id"
    class : "list-class"
    action : ->
      Session.set('eventTest', "insideData")
    items : [
      {
        title :
          name : "First Item"
          class : "title-class-first"
        description:
          name : "First description"
          class : "description-class-first"
        id : "first-item-id"
        class : "first-item-class"
        action : ->
          Session.set('eventTest', "insideItem")
      },
      {
        class : "second-item-class"
        action : ->
          Session.set('eventTest', 'insideRow')
        cells : [
          {
            icons : [
              {
                id : "first-icon"
                class : "first-icon-class"
                icon : "first-icon"
                href : "first-icon-link"
                action : ->
                  Session.set('eventTest', "insideIcon")
              }
              {
                id : "second-icon"
                class : "second-icon-class"
                icon : "second-icon"
                href : "second-icon-link"
              }
            ]
          }
          {
            title : "Title One"
            description : "Description One"
            class : "first-cell-class"
            icons : [
              {
                icon : "first-icon"
              }
            ]
          }
          {
            title : "Title Two"
            description : "Description Two"
            class : "second-cell-class"
            action : ->
              Session.set('eventTest', 'insideCell')
          }
        ]
      }
      {
        class : "test-class test-class2"
        title : "Last Item"
        href : "/home"
        id : "last-item-id"
        icons : [
          {
            icon : "last-icon"
            class : "last-icon-class"
            id : "last-icon-id"
            href : "last-icon-href"
            action : ->
              Session.set('eventTest', 'insideLastIcon')
          }
        ]
      }
    ]


listTests =
  name : "Test list element"
  tests : [
    {
      name : "List : Helper"
      data : data.listComplete
      template : "TEList"
      test : (div)->
        # has list id
        expect(div.find("#list-id").length).toEqual(1)
        # has list class
        expect(div.find(".list-class").length).toEqual(1)

        # has first item class
        expect(div.find('.te-first-item').length).toEqual(1)
        # first item class is in the first item
        expect(div.find('[item="0"]').hasClass('te-first-item')).toBe(true)
        # has last item class
        expect(div.find('.te-last-item').length).toEqual(1)
        # last item class is in the last item
        expect(div.find('[item="2"]').hasClass('te-last-item')).toBe(true)
        # four items have title
        expect(div.find('.te-title').length).toEqual(4)
        # three items have description
        expect(div.find('.te-description').length).toEqual(3)

        # check single component item
          # id exists
        expect(div.find('#first-item-id').length).toEqual(1)
          # class exists
        expect(div.find('.first-item-class').length).toEqual(1)
        expect(div.find('.test-class').length).toEqual(1)
        expect(div.find('.test-class2').length).toEqual(1)
          # class in title object exists
        expect(div.find('.title-class-first').length).toEqual(1)
          # class in description object exists
        expect(div.find('.description-class-first').length).toEqual(1)
          # href exists
        expect(div.find('.test-class .te-content').attr('href')).toEqual('/home')
        expect(div.find('.test-class .last-icon-class').length).toEqual(1)
        expect(div.find('#last-icon-id').length).toEqual(1)
        expect(div.find('.test-class .last-icon-class').attr('href')).toEqual('last-icon-href')

        # check cells
          # icon in a cell is not displayed
        expect(div.find('.first-cell-class').find('.icon').length).toEqual(0)
          # three cells in a row
        expect(div.find('.second-item-class').find('td').length).toEqual(3)
          # id in icon exists
        expect(div.find('#first-icon').length).toEqual(1)
          # class in icon exists
        expect(div.find('.first-icon-class').length).toEqual(1)
          # three first cells
        expect(div.find('.te-first-cell').length).toEqual(3)
          #three last cells
        expect(div.find('.te-last-cell').length).toEqual(3)
          # icon href match
        expect(div.find('#second-icon').attr('href')).toEqual('second-icon-link')
          #icon exists
        expect(div.find('.fa-first-icon').length).toEqual(1)
          # check text
        expect(div.find('.first-cell-class .te-title').text()).toEqual('Title One')
    }
    {
      name : "List : Event, in item"
      data : data.listComplete
      template : "TEList"
      before : (div)->
        div.find('.title-class-first').trigger('click')
      test : (div)->
        expect(Session.get('eventTest')).toMatch("insideItem")
        Session.set('eventTest', undefined)
    }
    {
      name : "List : Event, in cell"
      data : data.listComplete
      template : "TEList"
      before : (div)->
        div.find('.second-cell-class').trigger('click')
      test : (div)->
        expect(Session.get('eventTest')).toMatch("insideCell")
        Session.set('eventTest', undefined)
    }
    {
      name : "List : Event, in row"
      data : data.listComplete
      template : "TEList"
      before : (div)->
        div.find('.second-icon-class').trigger('click')
      test : (div)->
        expect(Session.get('eventTest')).toMatch("insideRow")
        Session.set('eventTest', undefined)
    }
    {
      name : "List : Event, in icon"
      data : data.listComplete
      template : "TEList"
      before : (div)->
        div.find('.first-icon-class').trigger('click')
      test : (div)->
        expect(Session.get('eventTest')).toMatch("insideIcon")
        Session.set('eventTest', undefined)
    }
    {
      name : "List : Event, in last icon"
      data : data.listComplete
      template : "TEList"
      before : (div)->
        div.find('.last-icon-class').trigger('click')
      test : (div)->
        expect(Session.get('eventTest')).toMatch("insideLastIcon")
        Session.set('eventTest', undefined)
    }
    {
      name : "List : Event, in table"
      data : data.listComplete
      template : "TEList"
      before : (div)->
        div.find('.test-class').trigger('click')
      test : (div)->
        expect(Session.get('eventTest')).toMatch("insideData")
        Session.set('eventTest', undefined)
    }
  ]

tests.push listTests
