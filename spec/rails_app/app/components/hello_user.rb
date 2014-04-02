class HelloUser < Netzke::Base
  js_configure do |c|
    c.title = "Hello User component"
    c.on_ping_server = <<-JS
      function(){
        this.greetTheUser();
      }
    JS

    c.show_greeting = <<-JS
      function(greeting){
        this.setTitle("Server says " + greeting);
      }
    JS
  end

  action :ping_server

  def configure(c)
    c.user = 'Max'
    c.bbar = [:ping_server]
    super
    c.title = c.user
  end

  endpoint :greet_the_user do |params,this|
    this.show_greeting("Hello #{config.user}")
  end
end
