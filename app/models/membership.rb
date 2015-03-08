class Membership < ActiveRecord::Base
  ROLE = ["Member", "Owner"]
  validates :role, inclusion: ROLE

  belongs_to :user
  belongs_to :project
end
