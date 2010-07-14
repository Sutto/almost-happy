module AlmostHappy
  module Publishable
    extend ActiveSupport::Concern

    module InstanceMethods

      def published=(value)
        # Sets the attribute, uses the ar conversion method)
        if defined?(ActiveRecord)
          value = ActiveRecord::ConnectionAdapters::Column.value_to_boolean(value)
        else
          value = value.present? && !["0", "false"].include?(value.to_s)
        end
        if !published_at? && value
          self.published_at = value
        elsif published_at? && !value
          self.published_at = nil
        end
      end

      def published?
        published_at.present? && published_at <= Time.now
      end
      alias published published?

      def publish!
        update_attribute :published_at, Time.now
      end

    end

  end
end
