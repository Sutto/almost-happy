module AlmostHappy
  module ActiveRecordMixin
    extend ActiveSupport::Concern
    
    module ClassMethods
      
      def is_convertable(*args)
        include AlmostHappy::Convertable
        options = args.extract_options!
        fields  = args.map { |arg| arg.to_sym }.uniq
        self.convertable_fields += fields
        # Define accessors for each field.
        fields.each do |field|
          define_method(:"#{field}_as_html") { send(field).to_s.html_save }
        end
        validate_convertable_format if options[:validate]
      end
      
      def is_publishable
        include AlmostHappy::Publishable
        include AlmostHappy::Scopeable
      end
      
    end
    
  end
end