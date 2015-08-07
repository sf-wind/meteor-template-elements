
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
        chai.expect(div.find('.te-first-item').length).not.to.be.empty
        chai.expect(div.find('.te-last-item').length).not.to.be.empty
        chai.expect(div.find('#first-item-id').length).not.to.be.empty
        chai.expect(div.find('#third-item-id').length).to.equal(0)
        chai.expect(div.find('.te-title').length).to.equal(4)
        chai.expect(div.find('.te-description').length).to.equal(3)
        chai.expect(div.find('.test-class').length).to.equal(1)
        chai.expect(div.find('.test-class2').length).to.equal(1)
        chai.expect(div.find('.title-class-first').length).to.equal(1)
        chai.expect(div.find('.description-class-first').length).to.equal(1)
        chai.expect(div.find('.test-class').find('.te-content').attr('href')).to.equal('/home')
        chai.expect(div.find('[item="0"]').hasClass('te-first-item')).to.be.true

        # check cells
        chai.expect(div.find('.first-cell-class').find('.icon').length).to.equal(2)
        chai.expect(div.find('.first-item-class').find('td').length).to.equal(2)
        chai.expect(div.find('#first-icon').length).to.equal(1)
        chai.expect(div.find('.first-icon-class').length).to.equal(1)
        chai.expect(div.find('.te-first-cell').length).to.equal(3)
        chai.expect(div.find('.te-last-cell').length).to.equal(3)
        chai.expect(div.find('#second-icon').attr('href')).to.equal('second-icon-link')
        chai.expect(div.find('.fa-first-icon').length).to.equal(1)
    }
    {
      name : "Pagination : Helper, in range"
      data : data.paginationInRange
      template : "TEPagination"
      test : (div)->
        chai.expect(div.find('.te-one-page').length).to.equal(6)
        chai.expect(div.find('.te-page-previous').hasClass('te-page-3')).to.be.true
        chai.expect(div.find('.te-page-next').hasClass('te-page-5')).to.be.true
        chai.expect(div.find('.active').children('.te-page-4').length).to.equal(1)
        chai.expect(div.find('.te-page-2').length).to.equal(1)
        chai.expect(div.find('.te-page-3').length).to.equal(2)
        chai.expect(div.find('.te-page-4').length).to.equal(1)
        chai.expect(div.find('.te-page-5').length).to.equal(2)
        chai.expect(div.find('.te-page-2').attr('href')).to.equal('/page/1')
        chai.expect(div.find('.te-page-3').attr('href')).to.equal('/page/2')
        chai.expect(div.find('.te-page-4').attr('href')).to.equal('/page/3')
        chai.expect(div.find('.te-page-5').attr('href')).to.equal('/page/4')
    }
    {
      name : "Pagination : Helper, before range"
      data : data.paginationBeforeRange
      template : "TEPagination"
      test : (div)->
        chai.expect(div.find('.te-one-page').length).to.equal(7)
        chai.expect(div.find('.te-page-previous').hasClass('te-page-1')).to.be.true
        chai.expect(div.find('.te-page-next').hasClass('te-page-3')).to.be.true
        chai.expect(div.find('.active').children('.te-page-2').length).to.equal(1)
        chai.expect(div.find('.te-page-1').length).to.equal(2)
        chai.expect(div.find('.te-page-2').length).to.equal(1)
        chai.expect(div.find('.te-page-3').length).to.equal(2)
        chai.expect(div.find('.te-page-4').length).to.equal(1)
        chai.expect(div.find('.te-page-5').length).to.equal(1)

    }
    {
      name : "Pagination : Helper, after range"
      data : data.paginationAfterRange
      template : "TEPagination"
      test : (div)->
        chai.expect(div.find('.te-one-page').length).to.equal(6)
        chai.expect(div.find('.te-page-previous').hasClass('te-page-9')).to.be.true
        chai.expect(div.find('.te-page-next').hasClass('te-page-10')).to.be.true
        chai.expect(div.find('.active').children('.te-page-10').length).to.equal(1)
        chai.expect(div.find('.disabled').children('.te-page-next').length).to.equal(1)
        chai.expect(div.find('.te-page-7').length).to.equal(1)
        chai.expect(div.find('.te-page-8').length).to.equal(1)
        chai.expect(div.find('.te-page-9').length).to.equal(2)
        chai.expect(div.find('.te-page-10').length).to.equal(2)

    }
    {
      name : "Pagination : Event, in range"
      data : data.paginationInRange
      template : "TEPagination"
      before : (div)->
        div.find('.te-page-next').trigger('click')
      test : (div)->
        chai.expect(Session.get('page')).to.equal(4)
    }
    {
      name : "List : Event, in item"
      data : data.listComplete
      template : "TEList"
      before : (div)->
        div.find('.title-class-first').trigger('click')
      test : (div)->
        chai.expect(Session.get('eventTest')).to.equal("insideItem")
        Session.set('eventTest', undefined)
    }
    {
      name : "List : Event, in cell"
      data : data.listComplete
      template : "TEList"
      before : (div)->
        div.find('.third-icon-class').trigger('click')
      test : (div)->
        chai.expect(Session.get('eventTest')).to.equal("insideCell")
        Session.set('eventTest', undefined)
    }
    {
      name : "List : Event, in row"
      data : data.listComplete
      template : "TEList"
      before : (div)->
        div.find('.second-icon-class').trigger('click')
      test : (div)->
        chai.expect(Session.get('eventTest')).to.equal("insideRow")
        Session.set('eventTest', undefined)
    }
    {
      name : "List : Event, in icon"
      data : data.listComplete
      template : "TEList"
      before : (div)->
        div.find('.first-icon-class').trigger('click')
      test : (div)->
        chai.expect(Session.get('eventTest')).to.equal("insideIcon")
        Session.set('eventTest', undefined)
    }
    {
      name : "List : Event, in table"
      data : data.listComplete
      template : "TEList"
      before : (div)->
        div.find('.test-class').trigger('click')
      test : (div)->
        chai.expect(Session.get('eventTest')).to.equal("insideData")
        Session.set('eventTest', undefined)
    }
  ]

tests.push listTests
