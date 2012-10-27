# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  UserIndex          :integer
#  UserID             :string(255)
#  Password           :string(255)
#  UserName           :string(255)
#  AuthorizationLevel :integer
#  FaildAttempts      :integer
#  Salt               :integer
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

  attr_accessor :UserIndex #Probably going away soon
  attr_accessor :UserID
  attr_accessor :Password
  attr_accessor :UserName
  attr_accessor :AuthorizationLevel
  attr_accessor :FaildAttempts
  attr_accessor :Salt #Probably not needed because of bcrypt
  attr_accessor :created_on
  attr_accessor :updated_on
  attr_reader :id
  has_many :documents

  #initialize is Ruby's ctor
  def initialize(attribute = {})
    @UserIndex = attributes[:UserIndex]
    @UserID = attributes[:UserID]
    @Password = Password.create(attributes[:Password])
    @UserName = attributes[:UserName]
    @AuthorizationLevel = attributes[:AuthorizationLevel]
    @FailedAttempts = attributes[:FailedAttempts]
    @Salt = attributes[:Salt]
    @Email = attributes[:Email]
    @created_on = attributes[:created_on]
    @updated_on = attributes[:updated_on]
  end

  #self makes this a class method.  This should return an initialized User object
  # on successful authentication, and nil on failure.
  def self.authenticate_safely(userId, password)
    where("userId = ? AND password = ?", user_name, Password.create(password)).first
  end
end
