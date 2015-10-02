class Venue < ActiveRecord::Base
  resourcify
  has_many :promotions
end
