class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params) # change later
    if @user.save
      log_in(@user)
      flash[:success] = "Welcome to the Sample App!"
      # handle a successful save
      redirect_to @user
    else
      render 'new'
      # put errors on the new page?
    end

  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
