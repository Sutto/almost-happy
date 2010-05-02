module AlmostHappy
  module Publishable
    extend ActiveSupport::Concern
    
    module InstanceMethods
      
      def published?
        published_at.present? && published_at <= Time.now
      end
      
      def publish!
        update_attribute :published_at, Time.now
      end
      
    end
    
  end
end