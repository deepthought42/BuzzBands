class Package < ActiveRecord::Base
  has_many :accounts
end
