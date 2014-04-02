# require 'netzke-core'
# require 'netzke/workspace'

require 'active_support/dependencies'

# Make components auto-loadable
ActiveSupport::Dependencies.autoload_paths << File.dirname(__FILE__)
