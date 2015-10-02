class User < ActiveRecord::Base
  resourcify
  rolify :before_add => :assign_role

  belongs_to :role

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User


  private
    def assign_role
      Rails.Logger("shits' week!")
      self.role = Role.find_by name: "regular" if self.role.nil?
    end
end
