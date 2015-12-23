class Venue < ActiveRecord::Base
  has_many :promotions
  has_many :users, through: :users_venues
end
