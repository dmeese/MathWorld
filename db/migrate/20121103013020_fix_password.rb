class FixPassword < ActiveRecord::Migration
  def up
    rename_column :users, :Password, :password_digest
  end

  def down
    rename_column :table_name, :password_digest, :Password
  end
end
