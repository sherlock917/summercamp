class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String

  belongs_to :post
  belongs_to :member

end
