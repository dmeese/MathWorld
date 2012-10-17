class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
	t.string	:SessionID
	t.integer	:UserIndex
	t.datetime	:LastUpdate
    end
  end
end
