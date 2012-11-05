=begin
SessionsController handles login and logout, as that is tightly entwined 
with session setup and teardown.  On successful login, we also redirect
to a reasonable page.
=end
class SessionsController < ApplicationController

	#showing the login page requires no special action; just allow the page to show
	def showsignin
	end

	#after entering login credentials, see if we can't authenticate the user.
	#if not, present them a message and redirect back to the login page.
	#On success, remember them in the session.
	def login
		user = User.find_by_UserID(params[:session][:userid])
		if user && user.authenticate(params[:session][:password])
			session[:remember_token] = user.id
			if user.AuthorizationLevel == 1
				redirect_to '/documents'
			elsif user.AuthorizationLevel == 2
				redirect_to '/documents'
			elsif user.AuthorizationLevel > 2
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
		redirect_to '/'
	end
end
