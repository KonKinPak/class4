class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_user, only: %i[new create update destroy]
  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new

  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    unless(session[:user_id] == @post.user_id)
      redirect_to show3_path, notice: "That's not your id"
    else
      respond_to do |format|
        if @post.save
          format.html { redirect_to show3_path, notice: "Post was successfully created." }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end      
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @temp = Post.new(post_params)
    unless(session[:user_id] == @temp.user_id)
      redirect_to show3_path, notice: "That's not your id"
    else
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to show3_path, notice: "Post was successfully updated." }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to show3_path, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      @user = @post.user 
    end

    def set_user
      @user = User.find(session[:user_id])
    end
    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:msg, :user_id)
    end
    def user_params
      params.require(:user).permit(:email, :name, :birthday, :address, :postal_code,:password,:id)
    end
end
