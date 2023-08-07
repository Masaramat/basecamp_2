class ProjectUser < ApplicationRecord
  # defines relationship between project and users
  enum role: { regular: 0, admin: 1 }
  belongs_to :project
  belongs_to :user
end
