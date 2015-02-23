class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  def full_name
    first_name.capitalize + " " + last_name.capitalize
  end
end
