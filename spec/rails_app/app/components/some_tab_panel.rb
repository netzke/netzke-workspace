class SomeTabPanel < Netzke::Workspace::TabPanel
  action :new_tab
  action :current_tab
  action :close_all

  js_configure do |c|
    c.on_new_tab = <<-JS
      function() {
        this.index = this.index || 0;
        this.index++;
        this.loadTab("HelloUser", {clientConfig: {user: "User "+this.index}, newTab: true});
      }
    JS

    c.on_current_tab = <<-JS
      function() {
        this.index = this.index || 0;
        this.index++;
        this.loadTab("HelloUser", {clientConfig: {user: "User "+this.index}});
      }
    JS

    c.on_close_all = <<-JS
      function() { this.closeAllTabs(); }
    JS
  end

  component :tab do |c|
    super c
    c.user = c.client_config[:user]
  end

  def configure(c)
    super
    c.bbar = [:new_tab, :current_tab, :close_all]
  end
end
