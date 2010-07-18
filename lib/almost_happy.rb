require 'active_support'
require 'active_support/dependencies/autoload'
require 'active_support/core_ext/class/attribute'
require 'active_support/concern'

module AlmostHappy
  VERSION = '0.3.0'.freeze

  extend ActiveSupport::Autoload

  autoload :ActiveRecordMixin

  autoload :Convertor
  autoload :FormatValidator

  autoload :Convertable
  autoload :Scopeable
  autoload :Publishable

  ::ActiveRecord::Base.send :include, ActiveRecordMixin if defined?(::ActiveRecord::Base)

end
