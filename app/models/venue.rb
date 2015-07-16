class Venue < ActiveRecord::Base
  has_many :promotions
end
