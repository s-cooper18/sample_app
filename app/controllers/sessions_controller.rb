class SessionsController < ApplicationController
  def new
  end

  def create
    # find the user
    user = User.find_by(email: params[:session][:email].downcase)
    # if they do not exist -> error
    if user && user.authenticate(params[:session][:password])
      # log in and redirect to user's show page
      log_in user
      redirect_to user
    else
      # flash now disappears whenever there is a new request
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new' # with errors
    end
  end

  def destroy

  end
end
