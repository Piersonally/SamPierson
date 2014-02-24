class Quotation < ActiveRecord::Base

  belongs_to :quoter, class_name: 'Account'

  validates :quoter_id, :quote, :author, presence: true
end
