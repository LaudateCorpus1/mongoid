# frozen_string_literal: true

module Mongoid
  module Contextual
    class None
      include Enumerable
      include Queryable

      attr_reader :criteria, :klass

      # Check if the context is equal to the other object.
      #
      # @example Check equality.
      #   context == []
      #
      # @param [ Array ] other The other array.
      #
      # @return [ true, false ] If the objects are equal.
      def ==(other)
        other.is_a?(None)
      end

      # Allow distinct for null context.
      #
      # @example Get the distinct values.
      #   context.distinct(:name)
      #
      # @param [ String, Symbol ] field the name of the field.
      #
      # @return [ Array ] Empty Array
      def distinct(field)
        []
      end

      # Iterate over the null context. There are no documents to iterate over
      # in this case.
      #
      # @example Iterate over the context.
      #   context.each do |doc|
      #     puts doc.name
      #   end
      #
      # @return [ Enumerator ] The enumerator.
      def each
        if block_given?
          [].each { |doc| yield(doc) }
          self
        else
          to_enum
        end
      end

      # Do any documents exist for the context.
      #
      # @example Do any documents exist for the context.
      #   context.exists?
      #
      # @return [ true, false ] If the count is more than zero.
      def exists?; false; end


      # Allow pluck for null context.
      #
      # @example Allow pluck for null context.
      #   context.pluck(:name)
      #
      # @param [ String, Symbol, Array ] args Field or fields to pluck.
      #
      # @return [ Array ] Empty Array
      def pluck(*args)
        []
      end

      # Create the new null context.
      #
      # @example Create the new context.
      #   Null.new(criteria)
      #
      # @param [ Criteria ] criteria The criteria.
      def initialize(criteria)
        @criteria, @klass = criteria, criteria.klass
      end

      # Always returns nil.
      #
      # @example Get the last document.
      #   context.last
      #
      # @return [ nil ] Always nil.
      def last; nil; end

      # Always returns zero.
      #
      # @example Get the length of matching documents.
      #   context.length
      #
      # @return [ Integer ] Always zero.
      def length
        entries.length
      end
      alias :size :length

      alias :find_first :first
      alias :one :first
    end
  end
end
