module AlmostHappy
  module Scopeable
    extend ActiveSupport::Concern

    module ClassMethods

      def published
        where "#{quoted_table_name}.published_at IS NOT NULL AND #{quoted_table_name}.published_at <= ?", Time.now
      end

      def unpublished
        where "#{quoted_table_name}.published_at IS NULL OR #{quoted_table_name}.published_at > ?", Time.now
      end

      def ordered
        order "#{quoted_table_name}.published_at DESC"
      end

      def ordered_for_preview
        order "(#{quoted_table_name}.published_at IS NULL) DESC, #{quoted_table_name}.published_at DESC"
      end

    end

  end
end
