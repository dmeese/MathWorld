class AddRanktoDocs < ActiveRecord::Migration
  def change
  	add_column :documents, :rating_avg, :float
  	add_column :documents, :rating_count, :integer
  end
end
