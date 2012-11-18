# == Schema Information
#
# Table name: documents
#
#  id                 :integer          not null, primary key
#  filename           :string(255)
#  description        :string(255)
#  contents           :binary
#  owner              :string(255)
#  authorizationlevel :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :integer
#

=begin
File represents any image, document, or other  asset uploaded by a Registered 
Teacher or (rarely) Administrator.  These are stored in a configured Amazon
S3 storage bucket called MathWorld as a file. Every file uploaded belongs to 
the user who uploaded it, in a one-to-many relationship.

class File connects to the file records in the underlying database through
Rails' ActiveRecord functionality - this hides a lot of the implementation
from us, letting us focus on just what we want to do without dealing with
the database CRUD

currently, the default ActiveRecord functionality supplied by Rails does
everything we need.  We may need to revisit in the future, but this will do
for now

However we check the file size to be less than 128K
=end

require 'file_size_validator' 
require 'stripify' 

class Document < ActiveRecord::Base
  #belongs_to is an ActiveRecord method which establishes a 
  #foreign key relationship, with this record as the child
  belongs_to :user, :foreign_key => :id

  # Set up :filename, :contents, :authorizationlevel, and :description as 
  # mass-assignable (such as during construction)
  attr_accessible :filename, :contents, :description, :authorizationlevel
  mount_uploader :contents, DocumentUploader
  
  #Sets up foreign key relationship with the comments table/Comment model object.
  #This object is the parent record; the foreign key field in comments defaults to document_id.
  has_many :comments
  
  #Use ActiveRecord's built-in validators
  validates :contents,
    :presence => true, 
    :file_size => { 
      :maximum => 0.125.megabytes.to_i 
    } 
    
    #set up remove_evil as an event callback, to be called before
    #the record is committed to the data repository.
  before_save :remove_evil

  def remove_evil()
    self.filename = Stripify::stripify(self.filename)
    self.description = Stripify::stripify(self.description)
  end
end

