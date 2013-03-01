require 'singleton'

module Paperclip
  module Tasks
    class Attachments
      include Singleton

      def self.add(klass, attachment_name, attachment_options)
        instance.add(klass, attachment_name, attachment_options)
      end

      def self.clear
        instance.clear
      end

      def self.names_for(klass)
        instance.names_for(klass)
      end

      def self.each_definition(&block)
        instance.each_definition(&block)
      end

      def initialize
        clear
      end

      def add(klass, attachment_name, attachment_options)
        @attachments ||= {}
        @attachments[klass] ||= {}
        @attachments[klass][attachment_name] = attachment_options
      end

      def clear
        @attachments = Hash.new { |h,k| h[k] = {} }
      end

      def names_for(klass)
        @attachments[klass].keys
      end

      def each_definition
        @attachments.each do |klass, attachments|
          attachments.each do |name, options|
            yield klass, name, options
          end
        end
      end
    end
  end
end