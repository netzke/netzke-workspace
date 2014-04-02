# Initially adds a Dashboard tab, which stays open at all times
class TabPanelWithDashboard < SomeTabPanel
  def configure(c)
    super c
    c.items = [:dashboard, *c.items]
  end

  component :dashboard do |c|
    c.klass = Netzke::Core::Panel
    c.title = "Dashboard"
  end
end
