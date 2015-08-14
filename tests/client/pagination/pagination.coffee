data =
  paginationInRange :
      total : 100
      page_number : 3
      items_per_page : 10
      num_pager : 4
      getHREF : (idx)->
        return "/page/" + idx
      action : (e, tmpl, idx)->
        Session.set("page", idx)
        return
  paginationBeforeRange :
      total : 100
      page_number : 1
      items_per_page : 10
      num_pager : 5
      action : (e, tmpl, idx)->
        Session.set("page", idx)
        return
  paginationAfterRange :
      total : 100
      page_number : 9
      items_per_page : 10
      num_pager : 6

paginationTests =
  name : "Pagination Tests"
  tests : [
    {
      name : "Pagination : Helper, in range"
      data : data.paginationInRange
      template : "TEPagination"
      test : (div)->
        expect(div.find('.te-one-page').length).toEqual(6)
        expect(div.find('.te-page-previous').hasClass('te-page-2')).toBe(true)
        expect(div.find('.te-page-next').hasClass('te-page-4')).toBe(true)
        expect(div.find('.active').children('.te-page-3').length).toEqual(1)
        expect(div.find('.te-page-1').length).toEqual(1)
        expect(div.find('.te-page-2').length).toEqual(2)
        expect(div.find('.te-page-3').length).toEqual(1)
        expect(div.find('.te-page-4').length).toEqual(2)
        expect(div.find('.te-page-1').attr('href')).toEqual('/page/1')
        expect(div.find('.te-page-2').attr('href')).toEqual('/page/2')
        expect(div.find('.te-page-3').attr('href')).toEqual('/page/3')
        expect(div.find('.te-page-4').attr('href')).toEqual('/page/4')
    }
    {
      name : "Pagination : Helper, before range"
      data : data.paginationBeforeRange
      template : "TEPagination"
      test : (div)->
        expect(div.find('.te-one-page').length).toEqual(7)
        expect(div.find('.te-page-previous').hasClass('te-page-1')).toBe(true)
        expect(div.find('.te-page-next').hasClass('te-page-2')).toBe(true)
        expect(div.find('.active').children('.te-page-1').length).toEqual(1)
        expect(div.find('.disabled').children('.te-page-previous').length).toEqual(1)
        expect(div.find('.te-page-1').length).toEqual(2)
        expect(div.find('.te-page-2').length).toEqual(2)
        expect(div.find('.te-page-3').length).toEqual(1)
        expect(div.find('.te-page-4').length).toEqual(1)
        expect(div.find('.te-page-5').length).toEqual(1)

    }
    {
      name : "Pagination : Helper, after range"
      data : data.paginationAfterRange
      template : "TEPagination"
      test : (div)->
        expect(div.find('.te-one-page').length).toEqual(8)
        expect(div.find('.te-page-previous').hasClass('te-page-8')).toBe(true)
        expect(div.find('.te-page-next').hasClass('te-page-10')).toBe(true)
        expect(div.find('.active').children('.te-page-9').length).toEqual(1)
        expect(div.find('.te-page-5').length).toEqual(1)
        expect(div.find('.te-page-6').length).toEqual(1)
        expect(div.find('.te-page-7').length).toEqual(1)
        expect(div.find('.te-page-8').length).toEqual(2)
        expect(div.find('.te-page-9').length).toEqual(1)
        expect(div.find('.te-page-10').length).toEqual(2)

    }
    {
      name : "Pagination : Event, trigger next"
      data : data.paginationInRange
      template : "TEPagination"
      before : (div)->
        div.find('.te-page-next').trigger('click')
        return
      test : (div)->
        expect(Session.get('page')).toEqual(4)
        Session.set('page', undefined)
        return
    }
    {
      name : "Pagination : Event, trigger previous"
      data : data.paginationInRange
      template : "TEPagination"
      before : (div)->
        div.find('.te-page-previous > span').trigger('click')
        return
      test : (div)->
        expect(Session.get('page')).toEqual(2)
        Session.set('page', undefined)
        return
    }
    {
      name : "Pagination : Event, trigger page 5"
      data : data.paginationBeforeRange
      template : "TEPagination"
      before : (div)->
        div.find('.te-page-5').trigger('click')
        return
      test : (div)->
        expect(Session.get('page')).toEqual(5)
        Session.set('page', undefined)
        return
    }
    {
      name : "Pagination : Event, trigger disabled"
      data : data.paginationBeforeRange
      template : "TEPagination"
      before : (div)->
        Session.set('page', "text")
        div.find('.te-page-previous').trigger('click')
        return
      test : (div)->
        expect(Session.get('page')).toEqual("text")
        Session.set('page', undefined)
        return
    }
  ]

tests.push paginationTests
