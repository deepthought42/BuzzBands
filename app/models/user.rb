class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User

  has_many :user_venues
  has_many :venues, :through => :user_venues
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable

end
