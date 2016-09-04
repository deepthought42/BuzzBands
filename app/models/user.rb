class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User

  has_many :orders
  has_many :accountsUsers
  has_many :accounts, through: :accountsUsers

  enum role: [:user, :account_user, :admin, :hypedrive_employee]

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :confirmable

end
