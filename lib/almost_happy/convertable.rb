require 'set'

module AlmostHappy
  module Convertable
    extend ActiveSupport::Concern
    
    included do
      class_attribute :convertable_fields
      self.convertable_fields = Set.new
      before_save :process_convertable_sections
    end
    
    module ClassMethods
      
      def validate_convertable_format
        validates_with AlmostHappy::FormatValidator
      end
      
    end
    
    module InstanceMethods
      
      protected
      
      def process_convertable_sections
        convertable_fields.each do |field|
          AlmostHappy::Convertor.new(self, field).render if should_render?(field)
        end
      end
      
      def should_render?(field)
        send(:"rendered_#{field}").blank? || format_changed? || send(:"#{field}_changed?")
      end
      
    end
    
  end
end