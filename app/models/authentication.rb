class Authentication < ActiveRecord::Base
  validates :email, :password, presence: true
end
