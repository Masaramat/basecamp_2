class Project < ApplicationRecord
    # Defines rewlationship between projects and users
    has_many :project_users, dependent: :destroy
    has_many :users, :through => :project_users
    # This is to handle foreign key constriant when destroying a project
    before_destroy :delete_project_users

    private
    # Ensures all relationships with the project are destroyed
    def delete_project_users
        project_users.destroy_all
    end
end
