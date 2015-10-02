class User < ActiveRecord::Base
  resourcify
  rolify

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  before_create :default_role

  private
  def default_role
    self.roles << Role.where(:name => 'regular').first
  end
end
