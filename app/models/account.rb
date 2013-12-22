class Account < ActiveRecord::Base
  has_many :posts, foreign_key: 'author_id', inverse_of: :author

  has_secure_password

  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: true

  def full_name
    [first_name, last_name].reject(&:blank?).join(' ')
  end
end
