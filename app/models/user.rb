# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  UserID             :string(255)
#  password_digest    :string(255)
#  UserName           :string(255)
#  AuthorizationLevel :integer
#  FaildAttempts      :integer
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
  attr_accessible :UserID, :UserName, :password, :password_confirmation, :AuthorizationLevel
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
  validates_confirmation_of :password
  has_many :documents
end
