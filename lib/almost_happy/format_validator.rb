module AlmostHappy
  class FormatValidator < ActiveModel::Validator
    
    def validate(record)
      if record && record.respond_to?(:format)
        format = record.format
        if format.present? && !AlmostHappy::Convertor.valid_format?(format)
          record.errors.add :format, :invalid_format,
            :default => 'is not a valid format (must be one of {{formats}})',
            :formats => AlmostHappy::Convertor.format_names
        end
      end
    end
    
  end
end