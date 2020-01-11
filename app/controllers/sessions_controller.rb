class SessionsController < ApplicationController
  def new
  end

  def create
    # find the user
    @user = User.find_by(email: params[:session][:email].downcase)
    # if they do not exist -> error
    if @user && @user.authenticate(params[:session][:password])
      # log in and redirect to user's show page
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to @user
    else
      # flash now disappears whenever there is a new request
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new' # with errors
    end
  end

  def destroy
    # log out
    # delete the user session
    # if logged in, log out
    log_out if logged_in?
    # redirect the page
    redirect_to root_url
  end
end
