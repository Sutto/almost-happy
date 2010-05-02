require 'active_support'
require 'active_support/dependencies/autoload'
require 'active_support/core_ext/class/attribute'
require 'active_support/concern'

module AlmostHappy
  VERSION = '0.1.0'.freeze
  
  autoload :Convertable
  autoload :Convertor
  autoload :Scopeable
  autoload :ActiveRecordMixin
  autoload :FormatValidator
  
  ::ActiveRecord::Base.send :include, ActiveRecordMixin if defined?(::ActiveRecord::Base)
  
end