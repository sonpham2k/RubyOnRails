class MicropostsController < ApplicationController
  before_action :set_micropost, only: %i[ show edit update destroy ]
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  # GET /microposts or /microposts.json
  def index
    # abort ActiveRecord::Base.connection_config.inspect
    @microposts = Micropost.paginate(page: params[:page],:per_page => 30)
  end

  # GET /microposts/1 or /microposts/1.json
  def show
  end

  # GET /microposts/new
  def new
    @micropost = Micropost.new
  end

  # GET /microposts/1/edit
  def edit
  end

  # POST /microposts or /microposts.json
  def create
    # @micropost = Micropost.new(micropost_params)

    # respond_to do |format|
    #   if @micropost.save
    #     format.html { redirect_to micropost_url(@micropost), notice: "Micropost was successfully created." }
    #     format.json { render :show, status: :created, location: @micropost }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @micropost.errors, status: :unprocessable_entity }
    #   end
    # end
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to microposts_path
    else
      @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 10)
      render 'static_pages/home'
    end
  end

  # PATCH/PUT /microposts/1 or /microposts/1.json
  def update
    respond_to do |format|
      if @micropost.update(micropost_params)
        format.html { redirect_to micropost_url(@micropost), notice: "Micropost was successfully updated." }
        format.json { render :show, status: :ok, location: @micropost }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microposts/1 or /microposts/1.json
  def destroy
    @micropost.destroy

    # respond_to do |format|
    #   format.html { redirect_to microposts_url, notice: "Micropost was successfully destroyed." }
    #   format.json { head :no_content }
    # end
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || microposts_url

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def micropost_params
      params.require(:micropost).permit(:content, :user_id)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
