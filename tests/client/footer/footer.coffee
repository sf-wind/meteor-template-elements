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
        chai.expect(div.find('#te-footer').length).to.equal(0)
    }
    {
      name : "Footer, helper, items"
      data : data.footerComplete
      template : "TEFooter"
      test : (div) ->
        chai.expect(div.find('.item-1').hasClass('active')).to.be.true
        chai.expect(div.find('.item-1').attr('href')).to.equal('/item/1')
        chai.expect(div.find('.item-1').find('.fa-icon-1').length).to.equal(1)
        chai.expect(div.find('.item-1').find('.te-footer-label').length).to.equal(1)
    }
    {
      name : "Footer, event, click"
      data : data.footerComplete
      template : "TEFooter"
      before : (div) ->
        div.find('.item-1').trigger('click')
      test : (div) ->
        chai.expect(Session.get('footerTest')).to.equal('footerItem')
        Session.set('footerTest', undefined)
    }
  ]

tests.push footerTests
