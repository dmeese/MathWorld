class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to :action => 'index'
    else
      render 'new'
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

  def update
    #return render :text => params
    @user = User.find(params[:user][:id])
    if @user.update_attributes(params[:user])
      redirect_to :action => 'index'
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if (@user)
      @user.destroy
    end
    redirect_to :action => 'index'
  end
end
