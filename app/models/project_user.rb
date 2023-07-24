class ProjectUser < ApplicationRecord
  # defines relationship between project and users
  belongs_to :project
  belongs_to :user
end
