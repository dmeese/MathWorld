class AddUserIdToFiles < ActiveRecord::Migration
  def change
    add_column :files, :user_id, :integer
  end
end
