=begin
The security module both defines function identifiers for the different functions executed
by the MathWorld application and provides an Authorized method for testing if a user
is authorized to execute a particular function.  
=end

require 'set'
require './User.rb'

module Security
  ADD_USER = 1
  DELETE_USER = 2
  VIEW_USER = 3
  VIEW_PUBLIC_FILE = 4
  VIEW_PRIVATE_FILE = 5
  UPLOAD_FILE = 6
  EDIT_OWN_FILE_ACCESS = 7
  EDIT_ANY_FILE_ACCESS = 8
  MAX_FUNCTION = 9

  GUEST_FUNCTIONS = Set[VIEW_PUBLIC_FILE]
  STUDENT_FUNCTIONS = Set[VIEW_PRIVATE_FILE]
  INSTRUCTOR_FUNCTIONS = Set[UPLOAD_FILE, EDIT_OWN_FILE_ACCESS]
  ADMIN_FUNCTIONS = Set[ADD_USER, DELETE_USER, VIEW_USER, EDIT_ANY_FILE_ACCESS]

  #Authorized returns true if the passed-in user is authorized for the particular function
  #false otherwise
  def Authorized(user, function)
    return false unless user.instance_of? User # user must be an instance of the User class

    return false if function <=0 # return false on out-of-range function codes
    return false if function >= MAX_FUNCTION    

    if GUEST_FUNCTIONS.include?(function) && user.AuthorizationLevel >= 1 then return true
    elsif STUDENT_FUNCTIONS.include?(function) && user.AuthorizationLevel >= 2 then return true
    elsif INSTRUCTOR_FUNCTIONS.include?(function) && user.AuthorizationLevel >= 3 then return true
    elsif ADMIN_FUNCTIONS.include?(function) && user.AuthorizationLevel >= 4 then return true
    end

    return false 
  end

  module_function :Authorized
end