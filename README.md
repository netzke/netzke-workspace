# Netzke::Workspace

Provides a tab-panel-based Netzke component that:

  * allows dynamic loading of arbitrary Netzke components in (new or currently active tab)

  * handles persistence of open tabs

  * provides a method that unloads all tabs at once

## Installation

Add this line to your application's Gemfile:

    gem 'netzke-workspace'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install netzke-workspace

## Usage

Inherit your workspace component from Netzke::Workspace::TabPanel. Then on the client side call the `loadTab` method to dynamically load components, e.g. (the `HelloWorld` component is supposed to be defined elsewhere):

    class MyTabPanel < Netzke::Workspace::TabPanel
      action :load_component

      js_configure do |c|
        c.on_load_component = <<-JS
          function() {
            this.loadTab("HelloWorld", newTab: true});
          }
        JS
      end

      def configure(c)
        super
        c.bbar = [:load_component]
      end
    end

See `spec/rails_app/app/components` for more examples.

## Running tests

    $ rspec spec

## Contributing

1. Fork it ( http://github.com/<my-github-username>/netzke-workspace/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
