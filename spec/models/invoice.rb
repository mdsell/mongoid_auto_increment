class Invoice
  include Mongoid::Document

  field :description

  auto_increment :num, :seed => 1000, :step => 5
end

