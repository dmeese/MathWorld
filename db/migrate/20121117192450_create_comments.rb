class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body
      t.integer :document_id
      t.string :commenter

      t.timestamps
    end
  end
end
