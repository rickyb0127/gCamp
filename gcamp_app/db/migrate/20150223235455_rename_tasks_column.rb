class RenameTasksColumn < ActiveRecord::Migration
  def change
    rename_column :tasks, :title, :description
  end
end
