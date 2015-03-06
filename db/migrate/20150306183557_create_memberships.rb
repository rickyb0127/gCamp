class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :role
      t.integer :user_id

      t.timestamp null: false
    end
  end
end
