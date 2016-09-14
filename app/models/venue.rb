class Venue < ActiveRecord::Base
  attr_accessor :promo_count

  has_many :promotions
  has_many :orders
  has_many :scans
  belongs_to :account

  geocoded_by :full_street_address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address? }

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :num_bars, numericality: { only_integer: true }, allow_blank: true
  validates :num_beers_on_tap, numericality: { only_integer: true }, allow_blank: true
  validates :womensBathroom, numericality: { only_integer: true }, allow_blank: true
  validates :mensBathroom, numericality: { only_integer: true }, allow_blank: true
  validates :phone, numericality: { only_integer: true }, allow_blank: true

  def full_street_address
    [address, city, state, zip_code].compact.join(', ')
  end

  def attributes
    super.merge('promo_count' => self.promo_count)
  end
end
