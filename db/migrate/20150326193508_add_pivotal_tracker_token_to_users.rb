class AddPivotalTrackerTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pivotal_tracker_token, :string, null: :false
  end
end
