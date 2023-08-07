class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # defines relationship for users and projects and ensures relationship is destroyed with user
  has_many :project_users, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :projects, :through => :project_users
  # Enum to represent roles which is represented by the index of the enum
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
  # Sets default privilage to user
  def set_default_role
    self.role ||= :user
  end
end
