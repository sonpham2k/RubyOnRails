class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  # before_action :valid_user, only: [:edit, :update]
  # before_action :check_expiration, only: [:edit, :update]

  def new
    @user = User.new
  end

  def store
    # update reset_digest to user
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user
      @user.reset_digest = (0...8).map { (65 + rand(26)).chr }.join
      @user.save
      flash[:info] = "Email sent with password reset instructions"
      render 'edit'
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def change_password
    @reset_digest = params[:reset_digest]
    @user = User.find_by(reset_digest: @reset_digest)
    render 'edit'
  end

  # def create
  #   @user = User.find_by(email: params[:password_reset][:email].downcase)
  #   if @user
  #     @user.create_reset_digest
  #     @user.send_password_reset_email
  #     flash[:info] = "Email sent with password reset instructions"
  #     redirect_to helf_url
  #   else
  #     flash.now[:danger] = "Email address not found"
  #     render 'new'
  #   end
  # end

  def edit
  end

  def update
    @email = params[:email]
    @password = params[:user][:password]
    @password_confirmation = params[:user][:password_confirmation]
    if params[:user][:password].empty?

    end
    @user.update(user_params)
    @user.inspect

    flash[:success] = "Password has been reset."
    redirect_to @user
  end

  # $2a$12$WGMKrIub6zLh/3n6DIu5x.LeKXBoNde5IsW0o6VO/MI.
  # $2a$12$pUnApjP.0Q7lBov.Hy.VBuk/CdyoA1MjPJiBsf5KyaF.

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def password_params
      params.permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # Confirms a valid user.
    # def valid_user
    #   unless (@user && @user.activated? &&
    #           @user.authenticated?(:reset, params[:id]))
    #       redirect_to root_url
    #   end
    # end

    # Checks expiration of reset token.
    # def check_expiration
    #   if @user.password_reset_expired?
    #     flash[:danger] = "Password reset has expired."
    #     redirect_to new_password_reset_url
    #   end
    # end
end
