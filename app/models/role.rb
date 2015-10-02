class Role < ActiveRecord::Base
  resourcify
  has_many :users

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify
end
