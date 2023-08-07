class Topic < ApplicationRecord
  has_many :messages
  belongs_to :user
  belongs_to :project
end
