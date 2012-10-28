class RemoveUserIndexFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :UserIndex
  end

  def down
    add_column :users, :UserIndex, :integer
  end
end
