class Venue < ActiveRecord::Base
  has_many :promotions
  has_many :orders
  belongs_to :account

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
end
