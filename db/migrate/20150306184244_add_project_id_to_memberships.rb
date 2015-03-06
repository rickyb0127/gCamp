class AddProjectIdToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :project_id, :integer
  end
end
