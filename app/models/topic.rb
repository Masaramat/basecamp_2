class Topic < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :user
  belongs_to :project
end
