describe 'SecureTabPanel component', ->
  it 'does not allow loading HelloUser', (done) ->
    click button "New tab"
    wait ->
      expectToSee tab "HelloUser not allowed"
      done()
