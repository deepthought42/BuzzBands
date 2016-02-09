class Scan < ActiveRecord::Base
  belongs_to :venue

  validates :uuid, presence: true
end
