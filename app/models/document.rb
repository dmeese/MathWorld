# == Schema Information
#
# Table name: documents
#
#  id                 :integer          not null, primary key
#  FileIndex          :integer
#  FileName           :string(255)
#  Description        :string(255)
#  Contents           :binary
#  Owner              :string(255)
#  AuthorizationLevel :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :integer
#

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

class Document < ActiveRecord::Base
  attr_accessor :FileIndex # Probably to be removed in the near future
  attr_accessor :FileName
  attr_accessor :Description
  attr_accessor :Contents
  attr_accessor :Owner
  attr_accessor :AuthorizationLevel
  attr_accessor :created_at
  attr_accessor :updated_at
  attr_accessor :user_id
  attr_reader  :id #FileIndex is assigned by the backend, and is never settable
  belongs_to :user, :foreign_key => :id

  #initialize is Ruby's ctor
  def initialize(attribute = {})
    @FileIndex = attributes[:FileIndex]
    @FileName = attributes[:FileName]
    @Description = attributes[:Description]
    @Contents = attributes[:Contents]
    @Owner = attributes[:Owner]
    @AuthorizationLevel = attributes[:AuthorizationLevel]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @user_id = attributes[:user_id]
  end
end
