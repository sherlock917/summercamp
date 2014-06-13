class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :content, type: String
  field :cate, type: String
  field :attachments, type: Array, default: []

  belongs_to :member

  has_many :comments

end
