data =
  footerComplete :
    items : [
      {
        class : "item-1"
        active : true
        href : "/item/1"
        icon : "icon-1"
        label : "label-1"
        action : ->
          Session.set('footerTest', "footerItem")
      }
    ]

footerTests =
  name : "Test footer element"
  tests : [
    {
      name : "Footer, helper, no footer"
      data : undefined
      template : "TEFooter"
      test : (div) ->
        expect(div.find('#te-footer').length).toEqual(0)
    }
    {
      name : "Footer, helper, items"
      data : data.footerComplete
      template : "TEFooter"
      test : (div) ->
        expect(div.find('.item-1').hasClass('active')).toBe(true)
        expect(div.find('.item-1').attr('href')).toEqual('/item/1')
        expect(div.find('.item-1').find('.fa-icon-1').length).toEqual(1)
        expect(div.find('.item-1').find('.te-footer-label').length).toEqual(1)
    }
    {
      name : "Footer, event, click"
      data : data.footerComplete
      template : "TEFooter"
      before : (div) ->
        div.find('.item-1').trigger('click')
      test : (div) ->
        expect(Session.get('footerTest')).toEqual('footerItem')
        Session.set('footerTest', undefined)
    }
  ]

tests.push footerTests
