class Account < ActiveRecord::Base
  has_many :venues
  has_many :users
end
