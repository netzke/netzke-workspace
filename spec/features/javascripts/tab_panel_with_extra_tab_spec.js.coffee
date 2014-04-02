describe 'TabPanelWithDashboard component', ->
  it 'closes all tabs except Dashboard', (done) ->
    click button "New tab"
    wait ->
      expectToSee tab "User 1"
      click button "Close all"
      wait ->
        expectToSee tab "Dashboard"
        done()
