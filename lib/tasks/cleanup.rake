namespace :cleanup do
  desc "Deletes all memberships where their users have already been deleted"
  task delete_memberships_without_users: :environment do
    Membership.where(user_id = nil).destroy_all
  end

  desc "Deletes all memberships where their projects have already been deleted"
  task delete_memberships_without_projects: :environment do
    Membership.where(project_id = nil).destroy_all
  end

  desc "Deletes all tasks where their projects have been deleted"
  task delete_tasks_without_projects: :environment do
    Task.where(project_id = nil).destroy_all
  end

  desc "Deletes all comments where their tasks have been deleted"
  task delete_comments_without_tasks: :environment do
    Comment.where(task_id = nil).destroy_all
  end

  desc "Deletes any tasks with null project_id"
  task delete_tasks_without_projects: :environment do
    Task.where(project_id = nil).destroy_all
  end

  desc "Deletes any comments with a null task_id"
  task delete_comments_without_tasks: :environment do
    Comment.where(task_id = nil).destroy_all
  end

  desc "Deletes any memberships with a null project_id or task_id"
  task delete_memberships_without_project_or_task: :environment do
    Membership.where(project_id = nil).destroy_all
    Membership.where(task_id = nil).destroy_all
  end

  desc "Sets the user_id of comments to nil if their users have been deleted"
  task set_comments_user_to_nil_without_users: :environment do
    Comment.where(user_id = nil).destroy_all
  end
end
