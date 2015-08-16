data =
  codeRemote :
    id : 'footer-example'
    lang : "handlebars"
    dir : '/packages/fsun:template-elements/tests/client/code/'
  codeLocal :
    id : "code-local"
    lang : "coffeescript"
    content : '''
Template.TECodeLocal.onRendered ->
  data = this.data
  if (data isnt undefined) and (typeof(hljs) is "object") and (not data.noHighlight)
    div = this.find('pre')
    if typeof (hljs.highlightBlock) is "function"
      hljs.highlightBlock(div)
'''

codeTests =
  name : "Test code element"
  tests : [
    {
      name : "Code, helper, remote"
      data : data.codeRemote
      template : "TECodeRemote"
      test : (div) ->
        #console.log div.html()
        expect(div.find('pre#footer-example').length).toEqual(1)
        expect(div.find('pre.handlebars').length).toEqual(1)
    }
    {
      name : "Code, helper, local"
      data : data.codeLocal
      template : "TECodeLocal"
      test : (div) ->
        #console.log div.html()
        expect(div.find('pre#code-local').length).toEqual(1)
        expect(div.find('pre.coffeescript').length).toEqual(1)
    }
  ]

tests.push codeTests
