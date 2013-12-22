class Post < ActiveRecord::Base

  belongs_to :author, class_name: 'Account', inverse_of: :posts

  validates :title, :author_id, presence: true
end
