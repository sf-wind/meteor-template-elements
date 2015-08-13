data =
  footerComplete :
    id : 'footer-id'
    class : 'footer-class'
    isInline : true
    items : [
      {
        class : "item-1"
        id : 'item-id-1'
        active : true
        href : "/item/1"
        icon : "icon-1"
        label : "label-1"
        action : ->
          Session.set('footerTest', "footerItem1")
      }
      {
        class : "item-2"
        href : "/item/2"
        icon : "icon-2"
        label : "label-2"
        action : ->
          Session.set('footerTest', "footerItem2")
      }
    ]
  footerFixed :
    items : [
      {
        class : "item-1"
        active : true
        href : "/item/1"
        icon : "icon-1"
        label : "label-1"
        action : ->
          Session.set('footerTest', "footerItem1")
      }
    ]
  footerFixedWidth :
    isFixedWidth : true
    items : [
      {
        class : "item-1"
        active : true
        href : "/item/1"
        icon : "icon-1"
        label : "label-1"
        action : ->
          Session.set('footerTest', "footerItem1")
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
        expect(div.find('#footer-id').length).toEqual(1)
        expect(div.find('.footer-class').length).toEqual(1)
        expect(div.find('.container-fluid').length).toEqual(1)
        expect(div.find('.navbar-fixed-bottom').length).toEqual(0)
        expect(div.find('#item-id-1').hasClass('item-1')).toBe(true)
        expect(div.find('.item-1').hasClass('active')).toBe(true)
        expect(div.find('.item-1').attr('href')).toEqual('/item/1')
        expect(div.find('.item-1').find('.fa-icon-1').length).toEqual(1)
        expect(div.find('.item-1').find('.te-footer-label').length).toEqual(1)
    }
    {
      name : "Footer, helper, fixed footer"
      data : data.footerFixed
      template : "TEFooter"
      test : (div) ->
        expect(div.find('.navbar-fixed-bottom').length).toEqual(1)
        expect(div.find('.container-fluid').length).toEqual(1)
    }
    {
      name : "Footer, helper, fixed footer width"
      data : data.footerFixedWidth
      template : "TEFooter"
      test : (div) ->
        expect(div.find('.container').length).toEqual(1)
    }
    {
      name : "Footer, event, click"
      data : data.footerComplete
      template : "TEFooter"
      before : (div) ->
        div.find('.item-1').trigger('click')
      test : (div) ->
        expect(Session.get('footerTest')).toEqual('footerItem1')
        Session.set('footerTest', undefined)
    }
  ]

tests.push footerTests
