class CreateDocumentHistories < ActiveRecord::Migration
  def change
    create_table :document_histories do |t|
      t.integer :document_id
      t.string :document_name
      t.integer :user_id
      t.string :user_name
      t.string :change_type

      t.timestamps
    end
  end
end
