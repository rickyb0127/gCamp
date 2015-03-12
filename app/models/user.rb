class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, confirmation: true

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships, dependent: :destroy
  has_many :comments, dependent: :nullify

  def full_name
    first_name.capitalize + " " + last_name.capitalize
  end
end
