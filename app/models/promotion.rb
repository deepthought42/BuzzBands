class Promotion < ActiveRecord::Base
  belongs_to :venue

  validates :name, presence: true, length: {minimum: 3}
  validates :ad_location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :venue_id, presence: true, numericality: { only_integer: true }
  validates :description, length: {minimum: 10}, allow_blank: true
end
