class CreateFiles < ActiveRecord::Migration
  def change
    create_table :files do |t|
      t.integer :FileIndex
      t.string :FileName
      t.string :Description
      t.binary :Contents
      t.string :Owner
      t.integer :AuthorizationLevel

      t.timestamps
    end
  end
end
