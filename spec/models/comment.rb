class Comment
  include Mongoid::Document

  field :body

  auto_increment :idn

  embedded_in :post
end
