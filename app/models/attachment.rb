class Attachment < ApplicationRecord
    belongs_to :project
    belongs_to :user
  
    has_one_attached :photo do |photo|
      photo.variant :thumb, resize_to_limit: [100, 100]
      photo.variant :medium, resize_to_limit: [400, 400]
      photo.variant :large, resize_to_limit: [800, 800]
    end
  end