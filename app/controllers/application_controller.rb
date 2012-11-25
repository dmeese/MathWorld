=begin
The ApplicationController class is the base class for all of the controllers for
the MathWorld application.  Any methods defined here are available to all of the controllers
and, through them, the views as well
=end
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #sets up the function getUser to be called on each request, before it gets dispatched to
  #the controller and action.  Prefacing getUser with a colon makes it a symbol in Ruby; it's
  #kind of like a string, but every :getUser is the same object as any other :getUser, while 
  #two different "getUser" instances are separate strings
  before_filter :getUser

  #session is defined by Rails for session storage. It's session cookie based, so
  #it goes away when the browser is closed.  For MathWorld, this is desirable.
  #session[:remember_token] is used to store the user id (the real underlying id, an integer)
  #for subsequent calls.  "protect_from_forgery" above tells Rails to use it's own system
  #to prevent forging the session values.
  #session[:last_seen] provides for timing out an inactive session
  def getUser
    if session[:remember_token] && session[:last_seen] && session[:last_seen] >= 15.minutes.ago
      @loggedinuser ||= User.find_by_id(session[:remember_token])
      session[:last_seen] = Time.now
    else
      @loggedinuser = nil
      if session[:remember_token]
        flash[:error] = "Session timed out."
      end
      session[:remember_token] = nil
      session[:last_seen] = nil
    end
  end
end
