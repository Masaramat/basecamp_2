class AddTopicToTopics < ActiveRecord::Migration[7.0]
  def change
    add_column :topics, :topic, :string
  end
end
