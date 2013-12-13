class Author
  include Mongoid::Document

  auto_increment :_id
  field :name, type: String
end
