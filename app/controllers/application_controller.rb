class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :getUser

  def getUser
  	if session[:remember_token]
  		@loggedinuser ||= User.find_by_id(session[:remember_token])
  	else
  		@loggedinuser = nil
  	end
  end
end
