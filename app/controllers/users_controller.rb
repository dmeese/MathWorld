class UsersController < ApplicationController
  def new
    @user = User.new
  end

# Only administrator with authorization level 4 can create a new user
  def create
    if @loggedinuser.AuthorizationLevel >= 4

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

  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

# Only administrator with authorization level 4 can update user account
  def update
    if @loggedinuser.AuthorizationLevel >= 4
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

# Only administrator with authorization level 4 can destroy existing user account
  def destroy
    if @loggedinuser.AuthorizationLevel >= 4
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
