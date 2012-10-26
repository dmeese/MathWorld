=begin
File represents any image, worksheet, or other large asset uploaded by a 
Registered Teacher or (rarely) Administrator.  These are stored directly in the
database as a blob.  Every file uploaded belongs to the user who uploaded it, in
a one-to-many relationship.

class File connects to the file records in the underlying database through
Rails' ActiveRecord functionality - this hides a lot of the implementation
from us, letting us focus on just what we want to do without dealing with
the database CRUD
=end

class File < ActiveRecord::Base
  attr_accessible :AuthorizationLevel, :Contents, :Description, :FileName, :Owner
  attr_readable :FileIndex #FileIndex is assigned by the backend, and is never settable
  belongs_to: user, :foreign_key => "UserIndex"

  #initialize is Ruby's ctor
  def initialize(attribute = {})
    @AuthorizationLevel = attributes[:AuthorizationLevel]
    @Contents = attributes[:Contents]
    @Description = attributes[:Description]
    @FileName = attributes[:FileName]
    @Owner = attributes[:Owner]
  end
end
