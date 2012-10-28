class RemoveSaltFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :Salt
  end

  def down
    add_column :users, :Salt, :integer
  end
end
