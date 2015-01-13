require 'mongoid_auto_increment/incrementor'

module MongoidAutoIncrement
  extend ActiveSupport::Concern

  module ClassMethods
    def auto_increment(name, options={})
      if name.to_sym == :_id
        field name, :type => Integer, :overwrite => true
      else
        field name, :type => Integer
      end

      seq_name = "#{self.name.downcase}_#{name}"

      unless defined?(@@incrementor)
        @@incrementor = MongoidAutoIncrement::Incrementor.new
      end

      before_create do
        unless self.respond_to?("#{name}?") && self.send("#{name}?")
          self.send "#{name}=", @@incrementor.inc(seq_name, options)
        end
      end
    end
  end
end

module Mongoid
  module Document
    include MongoidAutoIncrement
  end
end
