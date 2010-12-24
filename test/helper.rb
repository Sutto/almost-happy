$KCODE = 'UTF8'

require 'rubygems'

require 'test/unit'
require 'shoulda'
require 'rr'
require 'redgreen' if RUBY_VERSION < '1.9'
require 'ruby-debug' if ENV['DEBUG']

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'active_record'
require 'almost-happy'
require 'model_definitions'

class Test::Unit::TestCase
  include RR::Adapters::TestUnit
  extend ReversibleData::ShouldaMacros
end
