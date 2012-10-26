class AddTimeStampsToFiles < ActiveRecord::Migration
  def change
    add_column :files, :created_on, :timestamp
    add_column :files, :updated_on, :timestamp
  end
end
