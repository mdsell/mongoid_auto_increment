class Order
  include Mongoid::Document

  field :description

  auto_increment :num, :seed => 1000
end
