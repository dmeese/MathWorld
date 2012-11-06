class RenameAllNamesToLowercase < ActiveRecord::Migration
  def up
   rename_column :documents, :FileName, :filename
   rename_column :documents, :Description, :description
   rename_column :documents, :Owner, :owner
   rename_column :documents, :AuthorizationLevel, :authorizationlevel
   rename_column :sessions, :SessionID, :sessionid
   rename_column :sessions, :UserIndex, :userindex
   rename_column :sessions, :LastUpdate, :lastupdate
   rename_column :users, :UserID, :userid
   rename_column :users, :UserName, :username
   rename_column :users, :AuthorizationLevel, :authorizationlevel
   rename_column :users, :FaildAttempts, :faildattempts
  end

  def down
   rename_column :documents, :filename, :FileName
   rename_column :documents, :description, :Description
   rename_column :documents, :owner, :Owner
   rename_column :documents, :authorizationlevel, :AuthorizationLevel
   rename_column :sessions, :sessionid, :SessionID
   rename_column :sessions, :userindex, :UserIndex
   rename_column :sessions, :lastupdate, :LastUpdate
   rename_column :users, :userid, :UserID
   rename_column :users, :username, :UserName
   rename_column :users, :authorizationlevel, :AuthorizationLevel
   rename_column :users, :faildattempts, :FaildAttempts
  end
end
