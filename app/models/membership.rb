class Membership < ActiveRecord::Base
  ROLE = ["Member", "Owner"]
  validates :role, inclusion: ROLE

  belongs_to :user
  belongs_to :project
  validates :user, presence: true
  validates :user, uniqueness: {scope: :project_id, message: "has already been added to this project"}
end
