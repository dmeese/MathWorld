class RemoveFileIndexFromDocument < ActiveRecord::Migration
  def up
    remove_column :documents, :FileIndex
  end

  def down
    add_column :documents, :FileIndex, :integer
  end
end
