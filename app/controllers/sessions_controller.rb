class SessionsController < ApplicationController
	def showsignin
	end

	def login
		user = User.find_by_UserID(params[:session][:userid])
		if user && user.authenticate(params[:session][:password])
			session[:remember_token] = user.id
			if user.AuthorizationLevel == 1
				redirect_to '/math_content/public'
			elsif user.AuthorizationLevel == 2
				redirect_to '/math_content/student'
			elsif user.AuthorizationLevel > 2
				redirect_to '/math_content/teacher'
			else
				redirect_to '/math_content/public'
			end
		else
			flash[:error] = 'Invalid Login'
			redirect_to '/sessions'
		end
	end

	def logout
		session[:remember_token] = nil
		redirect_to '/'
	end
end
