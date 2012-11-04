class RenameContentsToContents < ActiveRecord::Migration
  def up
   rename_column :documents, :Contents, :contents
  end

  def down
   rename_column :documents, :contents, :Contents
  end
end
