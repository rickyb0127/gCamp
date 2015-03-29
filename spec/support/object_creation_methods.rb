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

def create_membership(options={})
  defaults = {
    user_id: create_user.id,
    project_id: create_project.id,
    role: "Member"
  }

  Membership.create!(defaults.merge(options))
end
