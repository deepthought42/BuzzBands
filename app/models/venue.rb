class Venue < ActiveRecord::Base
  attr_accessor :promo_count

  has_many :promotions
  has_many :orders
  has_many :scans
  belongs_to :account

  geocoded_by :full_street_address
  #reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, if: ->(obj){ obj.full_street_address.present? and obj.full_street_address? }

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true

  geocoded_by :full_street_address
  after_validation :geocode

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  def full_street_address
    [address, city, state, zip_code].compact.join(', ')
  end

  def attributes
    super.merge('promo_count' => self.promo_count)
  end
end
