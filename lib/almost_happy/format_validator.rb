module AlmostHappy
  class FormatValidator < ActiveModel::EachValidator
    
    def validate_each(record, attribute, value)
      if value.present? && !AlmostHappy::Convertor.valid_format?(value)
        record.errors.add attribute, :invalid_format,
          :default => 'is not a valid format (must be one of %{formats})',
          :formats => AlmostHappy::Convertor.format_names
      end
    end
    
  end
end