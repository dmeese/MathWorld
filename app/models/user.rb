# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  userid             :string(255)
#  password_digest    :string(255)
#  username           :string(255)
#  authorizationlevel :integer
#  faildattempts      :integer
#  created_on         :datetime
#  updated_on         :datetime
#

=begin
class User connects to the user records in the underlying database through
Rails' ActiveRecord functionality - this hides a lot of the implementation
from us, letting us focus on just what we want to do without dealing with
the database CRUD

The has_secure_password method gives us strong hashing via the bcrypt gem with salts built in
=end

class User < ActiveRecord::Base

  #Make all the fields mass-assignable (such as during construction)
  attr_accessible :userid, :username, :password, :password_confirmation, :authorizationlevel
  
  #Verify that password was entered and is at least 6 characters long
  validates :password, presence: true, length: { minimum: 6 }, :if => :validate_password?

  def validate_password?
    password.present? 
  end
  
  #The next two methods come from ActiveRecord.  They provide for the use
  #of cleartext passwords from the web app, with confirmation, and a digest being
  #saved in the database.  The digesting is performed using BCrypt.
  #To use has_secure_password, the database field must be named "password_digest".
  #Two methods are then exposed from User: password and password_confirmation
  #This is all handled automagically by ActiveRecord
  has_secure_password
  validates_confirmation_of :password
  
  #Sets up foreign key relationship with the documents table/Document model object.
  #This object is the parent record; the foreign key field in documents defaults to user_id.
  has_many :documents

  # Make sure we don't have any SQL injection in the user ID or User name.
  require 'stripify'

  #set up remove_evil as an event callback, to be called before
  #the record is committed to the database
  before_save :remove_evil

  def remove_evil()
    self.userid = Stripify::stripify(self.userid)
    self.username = Stripify::stripify(self.username)
  end

end
