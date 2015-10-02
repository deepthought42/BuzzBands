class Promotion < ActiveRecord::Base
  resourcify
  belongs_to :venue
end
