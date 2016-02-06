class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User

  has_many :orders
  belongs_to :account
  
  enum role: [:user, :account_user, :admin, :buzzbands_employee]

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  before_save -> do
     self.uid = SecureRandom.uuid
     skip_confirmation!
   end

end
