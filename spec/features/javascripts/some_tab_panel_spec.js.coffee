describe 'SomeTabPanel component', ->
  it 'loads component in new tab', (done) ->
    click button "Current tab"
    wait ->
      expectToSee tab "User 1"
      click button "Ping server"
      wait ->
        expectToSee header "Server says Hello User 1"
        click button "New tab"
        wait ->
          expectToSee tab "User 2"
          click button "Ping server"
          wait ->
            expectToSee header "Server says Hello User 2"
            done()
