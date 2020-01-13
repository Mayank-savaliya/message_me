class SessionsController < ApplicationController
  before_action :logged_in_redirect, only:[:new, :create]
  def new

  end
  def create
    user = User.find_by(username: params[:session][:username])
    #@inst = params[:session][:password]
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have logged in successfully"
      redirect_to root_path
    else
      flash.now[:error] = "There wass something wrong withthe credentials"
      render 'new'
    end
  end
  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to login_path
  end
  private
  def logged_in_redirect
    if logged_in?
      flash[:error] = "You re already logged in"
      redirect_to root_path
    end
  end
end
