
data =
  listComplete :
    items : [
      {
        title :
          name : "First Item"
          class : "title-class-first"
        description:
          name : "First description"
          class : "description-class-first"
        id : "first-item-id"
        action : ->
          Session.set('eventTest', "insideItem")
      },
      {
        class : "first-item-class"
        action : ->
          Session.set('eventTest', 'insideRow')
        cells : [
          {
            title : "Title One"
            description : "Description One"
            class : "first-cell-class"
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
            title : "Title Two"
            description : "Description Two"
            class : "second-cell-class"
            action : ->
              Session.set('eventTest', 'insideCell')
            icons : [
              {
                class : "third-icon-class"
                icon : "second-icon"
                href : "second-icon-link"
              }
              {
                class : "fourth-icon-class"
                icon : "second-icon"
                href : "second-icon-link"
              }
            ]
          }
        ]
      }
      {
        class : "test-class test-class2"
        title : "Last Item"
        href : "/home"
        id : "last-item-id"
      }
    ]
    action : ->
      Session.set('eventTest', "insideData")

  paginationInRange :
      total : 100
      page_number : 3
      items_per_page : 10
      num_pager : 4
      getHREF : (idx)->
        return "/page/" + idx
      action : (idx)->
        Session.set("page", idx)
  paginationBeforeRange :
      total : 100
      page_number : 1
      items_per_page : 10
      num_pager : 5
  paginationAfterRange :
      total : 100
      page_number : 9
      items_per_page : 10
      num_pager : 6

listTests =
  name : "Test list element"
  tests : [
    {
      name : "List : Helper"
      data : data.listComplete
      template : "TEList"
      test : (div)->
        # items without cells
        expect(div.find('.te-first-item').length).toEqual(1)
        expect(div.find('.te-last-item').length).toEqual(1)
        expect(div.find('#first-item-id').length).toEqual(1)
        expect(div.find('#third-item-id').length).toEqual(0)
        expect(div.find('.te-title').length).toEqual(4)
        expect(div.find('.te-description').length).toEqual(3)
        expect(div.find('.test-class').length).toEqual(1)
        expect(div.find('.test-class2').length).toEqual(1)
        expect(div.find('.title-class-first').length).toEqual(1)
        expect(div.find('.description-class-first').length).toEqual(1)
        expect(div.find('.test-class').find('.te-content').attr('href')).toEqual('/home')
        expect(div.find('[item="0"]').hasClass('te-first-item')).toBe(true)

        # check cells
        expect(div.find('.first-cell-class').find('.icon').length).toEqual(2)
        expect(div.find('.first-item-class').find('td').length).toEqual(2)
        expect(div.find('#first-icon').length).toEqual(1)
        expect(div.find('.first-icon-class').length).toEqual(1)
        expect(div.find('.te-first-cell').length).toEqual(3)
        expect(div.find('.te-last-cell').length).toEqual(3)
        expect(div.find('#second-icon').attr('href')).toEqual('second-icon-link')
        expect(div.find('.fa-first-icon').length).toEqual(1)
    }
    {
      name : "Pagination : Helper, in range"
      data : data.paginationInRange
      template : "TEPagination"
      test : (div)->
        expect(div.find('.te-one-page').length).toEqual(6)
        expect(div.find('.te-page-previous').hasClass('te-page-3')).toBe(true)
        expect(div.find('.te-page-next').hasClass('te-page-5')).toBe(true)
        expect(div.find('.active').children('.te-page-4').length).toEqual(1)
        expect(div.find('.te-page-2').length).toEqual(1)
        expect(div.find('.te-page-3').length).toEqual(2)
        expect(div.find('.te-page-4').length).toEqual(1)
        expect(div.find('.te-page-5').length).toEqual(2)
        expect(div.find('.te-page-2').attr('href')).toEqual('/page/1')
        expect(div.find('.te-page-3').attr('href')).toEqual('/page/2')
        expect(div.find('.te-page-4').attr('href')).toEqual('/page/3')
        expect(div.find('.te-page-5').attr('href')).toEqual('/page/4')
    }
    {
      name : "Pagination : Helper, before range"
      data : data.paginationBeforeRange
      template : "TEPagination"
      test : (div)->
        expect(div.find('.te-one-page').length).toEqual(7)
        expect(div.find('.te-page-previous').hasClass('te-page-1')).toBe(true)
        expect(div.find('.te-page-next').hasClass('te-page-3')).toBe(true)
        expect(div.find('.active').children('.te-page-2').length).toEqual(1)
        expect(div.find('.te-page-1').length).toEqual(2)
        expect(div.find('.te-page-2').length).toEqual(1)
        expect(div.find('.te-page-3').length).toEqual(2)
        expect(div.find('.te-page-4').length).toEqual(1)
        expect(div.find('.te-page-5').length).toEqual(1)

    }
    {
      name : "Pagination : Helper, after range"
      data : data.paginationAfterRange
      template : "TEPagination"
      test : (div)->
        expect(div.find('.te-one-page').length).toEqual(6)
        expect(div.find('.te-page-previous').hasClass('te-page-9')).toBe(true)
        expect(div.find('.te-page-next').hasClass('te-page-10')).toBe(true)
        expect(div.find('.active').children('.te-page-10').length).toEqual(1)
        expect(div.find('.disabled').children('.te-page-next').length).toEqual(1)
        expect(div.find('.te-page-7').length).toEqual(1)
        expect(div.find('.te-page-8').length).toEqual(1)
        expect(div.find('.te-page-9').length).toEqual(2)
        expect(div.find('.te-page-10').length).toEqual(2)

    }
    {
      name : "Pagination : Event, in range"
      data : data.paginationInRange
      template : "TEPagination"
      before : (div)->
        div.find('.te-page-next').trigger('click')
      test : (div)->
        expect(Session.get('page')).toEqual(4)
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
        div.find('.third-icon-class').trigger('click')
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
