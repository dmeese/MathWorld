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
  
  validates :userid, presence: true  #Verify that User ID is present - we gotta have this - Bug #7
  validates_uniqueness_of :userid    #Also do not allow duplicate user ids - Bug #15
  validate :userid_has_no_nonword_characters # see function definition - Bug #11
  
  #Verify that password was entered and is at least 8 characters long
  validates :password, presence: true, length: { minimum: 8 }, :if => :validate_password?
  validate :password_strong_enough

=begin
  Test for whether we should validate the password.  We only need to validate if this is
  a new user or if the password is changed
=end
  def validate_password?
    password.present? || new_record?
  end
  
=begin
  Test for password strength.  ActiveRecord doesn't have a built in validator for this,
  so use a custom validation method

  Right now we just check for three of the four following criteria:
    At least one lower case character
    At least one upper case character
    At least one digit
    At least one non-alpha, non-digit printable character

    Addresses Bug #5
=end
  def password_strong_enough
    return unless validate_password?

    count_symbols = /\W/.match(password) ? password.scan(/\W/).length : 0
    count_digits = /\d/.match(password) ? password.scan(/\d/).length : 0
    count_lowers = /[[:lower:]]/.match(password) ? password.scan(/[[:lower:]]/).length : 0
    count_uppers = /[[:upper:]]/.match(password) ? password.scan(/[[:upper:]]/).length : 0

    conditions = 0
    conditions += 1 if count_symbols >= 1
    conditions += 1 if count_digits >= 1
    conditions += 1 if count_lowers >= 1
    conditions += 1 if count_uppers >= 1

    if conditions < 3
      errors.add(:password, "must contain 3 of the following: 1 lower case letter, 1 upper case letter, 1 digit, 1 non-letter non-number.")
    end
  end

=begin
  Test for userid validity.  A valid userid only consists of alphanumeric characters (including underscore)
  ActiveRecord's validates_format_of doesn't quite do what we want,
  so use a custom validation method

  Addresses Bug #11
=end
  def userid_has_no_nonword_characters
    errors.add(:userid, "has invalid characters.  Please only uses letters, numbers, and underscores") if userid.match(/\W+/)
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
