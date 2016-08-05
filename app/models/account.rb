class Account < ActiveRecord::Base
  has_many :venues
  has_many :accountUsers
  has_many :users, through: :accountUsers
  belongs_to :user

  validates :user_id, presence: true
  #validates :stripe_customer_id, presence: true
end
