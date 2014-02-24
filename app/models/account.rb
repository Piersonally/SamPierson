class Account < ActiveRecord::Base
  has_many :articles, foreign_key: 'author_id', inverse_of: :author
  has_many :quotations, foreign_key: 'quoter_id', inverse_of: :quoter

  has_secure_password

  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: true

  def full_name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  concerning :Roles do
    included do
      serialize :roles, Array

      ROLES = %w(admin)

      ROLES.each do |role|
        define_method "is_#{role}?" do
          roles.include? role
        end
      end
    end
  end
end
