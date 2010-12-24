require 'helper'

class AlmostHappy::TestActiveRecordMixin < Test::Unit::TestCase
  
  context 'adding class methods' do
    
    should 'add the is_convertable method' do
      assert ActiveRecord::Base.respond_to?(:is_convertable)
    end
    
    should 'add the is_publishable method' do
      assert ActiveRecord::Base.respond_to?(:is_publishable)
    end
    
  end
  
  should 'automatically add itself to activerecord' do
    assert(ActiveRecord::Base < AlmostHappy::ActiveRecordMixin, 'AR::Base has the mixin')
  end
  
end
