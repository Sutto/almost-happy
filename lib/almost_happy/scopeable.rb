module AlmostHappy
  module Scopeable
    extend ActiveSupport::Concern

    module ClassMethods

      def published
        where 'published_at IS NOT NULL AND published_at <= ?', Time.now
      end

      def unpublished
        where 'published_at IS NULL OR published_at > ?', Time.now
      end

      def ordered
        order 'published_at DESC'
      end

      def ordered_for_preview
        order '(published_at IS NULL) DESC, published_at DESC'
      end

    end

  end
end
