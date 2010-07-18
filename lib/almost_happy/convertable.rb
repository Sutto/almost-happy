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

      def validate_convertable_format(*attrs)
        if attrs.empty?
          attrs = [:format]
        else
          attrs = attrs.map { |a| a.to_s.gsub(/(_format)?$/, '_format').to_sym }
        end
        validates_presence_of *attrs
        validates_with AlmostHappy::FormatValidator, :attributes => attrs
      end

    end

    module InstanceMethods

      protected

      def format_field_for(field)
        named_version = :"#{field}_format"
        respond_to?(named_version) ? named_version : :format
      end
      
      def format_for(field)
        send format_field_for(field)
      end
      
      def format_changed_for?(field)
        send :"#{format_field_for(field)}_changed?"
      end

      def process_convertable_sections
        convertable_fields.each do |field|
          AlmostHappy::Convertor.new(self, field).render if should_render?(field)
        end
      end

      def should_render?(field)
        send(:"rendered_#{field}").blank? || format_changed_for?(field) || send(:"#{field}_changed?")
      end

    end

  end
end
