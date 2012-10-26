class AddUpdatedOnToUser < ActiveRecord::Migration
  def change
    add_column :users, :updated_on, :timestamp
  end
end
