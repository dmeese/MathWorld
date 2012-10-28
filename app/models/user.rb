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

  #self makes this a class method.  This should return an initialized User object
  # on successful authentication, and nil on failure.
  def self.authenticate_safely(userId, password)
    where("userId = ? AND password = ?", userId, Password.create(password)).first
  end
end
