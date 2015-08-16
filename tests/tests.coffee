
for i in [0...tests.length]
  oneGroupTests = tests[i]
  describe  oneGroupTests.name, ->
    for i in [0...oneGroupTests.tests.length]
      test = oneGroupTests.tests[i]
      do (test) ->
        it test.name, ->
          expect(test.template).toBeDefined()
          expect(test.test).toBeDefined()
          div = document.createElement("div")
          #$('body').append(div)
          Blaze.renderWithData(Template[test.template], test.data, div)
#          console.log div
          if test.before
            test.before($(div))
          Tracker.flush()
          test.test($(div))
          $(div).remove()
