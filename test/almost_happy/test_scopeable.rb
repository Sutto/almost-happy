require 'helper'

class AlmostHappy::TestScopeable < Test::Unit::TestCase
  with_tables :publishable do
    
    should 'by default not be included' do
      assert  !(Publishable < AlmostHappy::Scopeable)
    end
    
    should 'be added by is_publishable' do
      Publishable.is_publishable
      assert Publishable < AlmostHappy::Scopeable
    end
    
    context 'with a publishable model' do
      
      setup { Publishable.is_publishable }
      
      should 'add a published relationship method' do
        assert Publishable.respond_to?(:published)
      end
      
      should 'add a unpublished relationship method' do
        assert Publishable.respond_to?(:unpublished)
      end
      
      should 'add a ordered relationship method' do
        assert Publishable.respond_to?(:ordered)
      end
      
      should 'add a ordered_for_preview relationship method' do
        assert Publishable.respond_to?(:ordered_for_preview)
      end
      
      should 'return a relationship from published' do
        assert Publishable.published.is_a?(ActiveRecord::Relation)
      end
      
      should 'return a relationship from unpublished' do
        assert Publishable.unpublished.is_a?(ActiveRecord::Relation)
      end
      
      should 'return a relationship from ordered' do
        assert Publishable.ordered.is_a?(ActiveRecord::Relation)
      end
      
      should 'return a relationship from ordered_for_preview' do
        assert Publishable.ordered_for_preview.is_a?(ActiveRecord::Relation)
      end
      
      context 'with published items do' do
        
        setup do
          @published_a = Publishable.create!(:published_at => 3.weeks.ago)
          @published_b = Publishable.create!(:published_at => 1.day.ago)
          @unpublished_a = Publishable.create!(:published_at => 3.weeks.from_now)
          @unpublished_b = Publishable.create!(:published_at => 2.hours.from_now)
          @unpublished_c = Publishable.create!(:published_at => nil)
        end
        
        should 'return the correct items for published' do
          assert_same_elements [@published_a, @published_b], Publishable.published.all
        end
        
        should 'return the correct items for unpublished' do
          assert_same_elements [@unpublished_a, @unpublished_b, @unpublished_c], Publishable.unpublished.all
        end
        
        should 'have the correct order for ordered' do
          assert_equal [@unpublished_a, @unpublished_b, @published_b, @published_a, @unpublished_c], Publishable.ordered.all
        end
        
        should 'have the correct order for ordered_for_preview' do
          assert_equal [@unpublished_c, @unpublished_a, @unpublished_b, @published_b, @published_a], Publishable.ordered_for_preview.all
        end
        
      end
      
    end
    
  end
end
