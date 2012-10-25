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

  attr_accessor :UserId, :AuthorizationLevel, :FailedAttempts, :Email
  attr_reader :UserIndex

  #initialize is Ruby's ctor
  def initialize(attribute = {})
    @UserIndex = attributes[:UserIndex]
    @UserId = attributes[:UserId]
    @Password = Password.create(attributes[:Password])
    @AuthorizationLevel = attributes[:AuthorizationLevel]
    @FailedAttempts = attributes[:FailedAttempts]
    @Email = attributes[:Email]
  end

  #self makes this a class method.  This should return an initialized User object
  # on successful authentication, and nil on failure.
  def self.authenticate_safely(userId, password)
    where("userId = ? AND password = ?", user_name, Password.create(password)).first
  end
end