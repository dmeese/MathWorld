class AddCreatedOnToUser < ActiveRecord::Migration
  def change
    add_column :users, :created_on, :timestamp
  end
end
