=begin
SessionsController handles login and logout, as that is tightly entwined 
with session setup and teardown.  On successful login, we also redirect
to a reasonable page.

Added session[:last_seen] to address bug #12
=end
class SessionsController < ApplicationController

	#if a logged in user pastes teh login page url in, it will direct them back to douments.
	def showsignin
		if @loggedinuser 
			redirect_to '/documents'
		end
	end

	#after entering login credentials, see if we can't authenticate the user.
	#if not, present them a message and redirect back to the login page.
	#On success, remember them in the session.
	def login
		user = User.find_by_userid(params[:session][:userid])
		if user && user.authenticate(params[:session][:password])
			session[:remember_token] = user.id
			session[:last_seen] = Time.now
			if user.authorizationlevel == 1
				redirect_to '/documents'
			elsif user.authorizationlevel == 2
				redirect_to '/documents'
			elsif user.authorizationlevel > 2
				redirect_to '/documents'
			else
				redirect_to '/'
			end
		else
			flash[:error] = 'Invalid Login'
			redirect_to '/sessions'
		end
	end

	#Remove the user from the session and send them to the home page.
	def logout
		session[:remember_token] = nil
		session[:last_seen] = nil
		redirect_to '/'
	end
end
