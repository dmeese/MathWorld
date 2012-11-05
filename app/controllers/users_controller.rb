=begin
UsersController handles user management.  Users are saved and retrieved in the database
vi the User model.  All functions in this controller should only be available to administrators
(those with Authorization Level 4)
=end
class UsersController < ApplicationController

  # create a new, empty user object prior to showing the user data
  #entry form
  def new
    if @loggedinuser && @loggedinuser.AuthorizationLevel >= 4
    	@user = User.new
    else 
       redirect_to '/'
    end
  end

  #Create a new user from data provided by the form.  If the save fails for
  #some reason, send back to the form so that errors can be corrected and try again.
  #On success, return to the list of users
  def create
    if @loggedinuser && @loggedinuser.AuthorizationLevel >= 4

        @user = User.new(params[:user])
        if @user.save
         redirect_to :action => 'index'
        else
         render 'new'
        end
    else 
       redirect_to '/'
    end
  end

  #Show the list of users
  def index
    if @loggedinuser && @loggedinuser.AuthorizationLevel >= 4
    else 
       redirect_to '/'
    end
  end

  #Show information for a single registered user.  The id to
  #retrieve comes from the URL
  def show
    if @loggedinuser && @loggedinuser.AuthorizationLevel >= 4
    	@user = User.find(params[:id])
    else 
       redirect_to '/'
    end
  end

  #Edit an existing user.  The user id to retrieve data for come from the URL
  def edit
    if @loggedinuser && @loggedinuser.AuthorizationLevel >= 4
    	@user = User.find(params[:id])
    else 
       redirect_to '/'
    end
  end

  #Update an existing user from data provided by the form.  If the save fails for
  #some reason, send back to the form so that errors can be corrected and try again.
  def update
    if @loggedinuser && @loggedinuser.AuthorizationLevel >= 4
    #return render :text => params
       @user = User.find(params[:user][:id])
       if @user.update_attributes(params[:user])
          redirect_to :action => 'index'
       else
         render 'edit'
       end
    else 
       redirect_to '/'
    end
  end

  #delete an existing user, with the id specified in the URL.  After delete, return to
  #the list of registered users.
  def destroy
    if @loggedinuser && @loggedinuser.AuthorizationLevel >= 4
       @user = User.find(params[:id])
       if (@user)
         @user.destroy
       end
       redirect_to :action => 'index'
    else
        redirect_to '/'
    end 
  end
end
