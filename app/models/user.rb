class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, confirmation: true

  has_many :memberships
  has_many :projects, through: :memberships

  def full_name
    first_name.capitalize + " " + last_name.capitalize
  end
end
