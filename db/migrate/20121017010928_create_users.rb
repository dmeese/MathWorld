class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
	t.integer   :UserIndex
	t.string	:UserID
	t.string	:Password
	t.string	:UserName
	t.integer	:AuthorizationLevel
	t.integer	:FaildAttempts
    end
  end
end
