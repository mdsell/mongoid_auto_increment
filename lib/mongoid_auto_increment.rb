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
      @@incrementor = MongoidAutoIncrement::Incrementor.new unless defined? @@incrementor

      before_create { self.send("#{name}=", @@incrementor.inc(seq_name, options)) }
    end
  end
end

module Mongoid
  module Document
    include MongoidAutoIncrement
  end
end
