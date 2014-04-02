module Netzke
  module Workspace
    # A component that allows for dynamical loading/unloading of other Netzke components in tabs.
    #
    # Call the +loadTab+ method on the client to dynamically load a component:
    #
    #   workspaceTabPanel.loadTab("UserGrid", {newTab: true})
    #
    # - will load a UserGrid component from the server in a new tab.
    #
    # == Client-side methods:
    #
    # +loadTab(componentClassName, options)+ - loads a component in a (new or currently active) tab
    #
    #   * +options+ is an object that may contain the following keys:
    #       * +newTab+ (boolean) - whether to load a component in a newly created tab
    #       * +clientConfig+ (object) - config for the loaded Netzke component
    #
    # +closeAllTabs+ - closes all open tabs
    #
    # == Security
    #
    # By default, this component allows loading any Netzke component as requested from the client (component
    # class has been sent as a paremeter for the deliver_component endpoint), which may not be secury enough for you.
    # Override the :tab component to do any proper checks (see an example in the specs app).
    #
    class TabPanel < Netzke::Base
      js_configure do |c|
        c.extend = "Ext.tab.Panel"
        c.header = false
        c.mixin
      end

      def configure(c)
        c.tabs = state[:tabs].presence
        super
      end

      component :tab do |c|
        # this hack is needed because of Netzke::Core's imperfection: it eagerly evaluates all components (even if those
        # would never be loaded) - and thus, a valid +klass+ is required.
        if c.client_config.empty?
          c.klass = Netzke::Core::Panel
        else
          c.klass = c.client_config[:klass].constantize
        end
      end

      def update_tab_session_config(c)
        tabs = state[:tabs] ||= {}
        if tab_index = c.delete(:tabIndex)
          tabs[tab_index] = c
        end
      end

      endpoint :server_save_tabs do |params, this|
        state[:tabs] = params
      end
    end
  end
end
