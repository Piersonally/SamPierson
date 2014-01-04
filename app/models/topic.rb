class Topic < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end
