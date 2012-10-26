class AddSaltToUser < ActiveRecord::Migration
  def change
    add_column :users, :Salt, :integer
  end
end
