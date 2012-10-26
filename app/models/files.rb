class Files < ActiveRecord::Base
  attr_accessible :AuthorizationLevel, :Contents, :Description, :FileIndex, :FileName, :Owner
end
