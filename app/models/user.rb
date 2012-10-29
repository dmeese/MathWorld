# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  UserID             :string(255)
#  Password           :string(255)
#  UserName           :string(255)
#  AuthorizationLevel :integer
#  FaildAttempts      :integer
#  created_on         :datetime
#  updated_on         :datetime
#


require 'bcrypt'
=begin
class User connects to the user records in the underlying database through
Rails' ActiveRecord functionality - this hides a lot of the implementation
from us, letting us focus on just what we want to do without dealing with
the database CRUD

The bcrypt gem gives us strong hashing with salts built in
=end

class User < ActiveRecord::Base
  include BCrypt

  has_many :documents

  #self makes this a class instance method, instead of an object instance method.  This should return an initialized User object
  # on successful authentication, and nil on failure.
  # userId is the id of the user to retrieve
  # password is the cleartext password of the user (from the login page)
  # BCrypt::Password is a class which also handles salting the hash; the salt is then stored in the same output as the hash
  def self.authenticate(userId, password)
    user = where("userId = ?", userId).first # get the user record from the database 

    # Initializing the Password object with a previous hash allows it to compare using the same hash the
    # original secret was stored with.  == has been overridden so a cleartext can be compared with the hash
    passwordhash = Password.new(user.Password)
    if passwordhash == password
    	return user # hash of cleartext using previous salt matches originally saved hash
    else
    	return nil # hashes don't match return null, nil, nothing
    end
  end

  # Override the default Password setter to encrypt (actually salt and hash) on set
  def Password=(secret)
  	self[:password] = Password.create(secret)
  end
end
