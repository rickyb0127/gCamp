def create_user(options={})
  defaults = {
    first_name: 'Joe',
    last_name: 'Person',
    email: 'jp@example.com',
    password: 'wookie'
  }
  User.create!(defaults.merge(options))
end

def create_project(options={})
  defaults = {
    name: 'Awesome Project'
  }
  Project.create!(defaults.merge(options))
end

def create_membership(project, user, options={})
  defaults = {
    user_id: user.id,
    project_id: project.id,
    role: "Member"
  }

  Membership.create!(defaults.merge(options))
end

def create_task(options={})
  defaults = {
    description: "do stuff",
    complete: false,
    due_date: '01/01/2016'
  }

  Task.create!(defaults.merge(options))
end
