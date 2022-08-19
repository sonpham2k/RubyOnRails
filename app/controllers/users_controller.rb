class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :logged_in_user, only: [:edit, :index, :update, :show]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  # GET /users or /users.json
  def index
    @users = User.paginate(page: params[:page],:per_page => 10)
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    # respond_to do |format|
      if @user.save
        # UserMailer.account_activation(@user).deliver_now
        @user.send_activation_email
        flash[:info] = "Please check your email to activate your account."
        redirect_to helf_url
        # log_in @user
        # flash[:success] = "Welcome to the Sample App!"
        # format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        # format.json { render :show, status: :created, location: @user }
      else
        # format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @user.errors, status: :unprocessable_entity }
        render 'new'
      # end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
      # respond_to do |format|
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
        # format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        # format.json { render :show, status: :ok, location: @user }
      else
        render 'edit'
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    # end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    # @user.destroy

    # respond_to do |format|
    #   format.html { redirect_to users_url, notice: "User was successfully destroyed." }
    #   format.json { head :no_content }
    # end
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                    :password_confirmation)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      # flash[:alert] = "You can't edit other uses!!"
      redirect_to(users_path) unless current_user?(@user)
    end

    #check admin
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
