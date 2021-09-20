class PostsController < ApplicationController
 before_action :set_user, only: %i[ show edit update destroy edit2 post newPost ]

  #before_action(:set_user, only: [:show, :edit, :update, :destroy])
  #do function set user before do
  def main
  end

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  def show2
  end

  def show3
    @user = User.find_by(email: params[:email])
    unless(@user.present? && @user.pass == params[:pass])
      redirect_to "/main" , alert: "Email/password not valid"
    end
  end
  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def edit2
  end
  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def editPost
    @user = User.find(params[:uid])
    @post = @user.posts.find(params[:pid] )
  end
  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        #redirect_to = go to url user
        format.html do
         redirect_to @user, notice: "User was successfully updated." 
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update2
    @user = User.find(params[:user][:id])
    respond_to do |format|
      if @user.update(user_params)
        #redirect_to = go to url user
        format.html do
         redirect_to "/show3?email=#{@user.email}&pass=#{@user.pass}", notice: "User was successfully updated." 
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def newPost
  end
  def post
  end
  def createPost
    @user = User.find(params[:user][:id])
    @post = @user.posts.create(msg: params[:user][:msg])

    respond_to do |format|
      if @user.save
        format.html { redirect_to "/show3?email=#{@user.email}&pass=#{@user.pass}", notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end   
  def updatePost
    @user = User.find(params[:post][:user_id])
    @post = @user.posts.find(params[:id])
    respond_to do |format|
      if @post.update(params[:post])
        #redirect_to = go to url user
        format.html do
         redirect_to "/show3?email=#{@user.email}&pass=#{@user.pass}", notice: "Post was successfully updated." 
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    #respond_to do |format|
    #  format.html { redirect_to users, notice: "User was successfully destroyed." }
    #  format.json { head :no_content }
    #end
    #respond_to do |format|
    # format.html { redirect_to "/users/show2?id=#{@user.id}", notice: "User was successfully destroyed." }
    # format.json { head :no_content }
    #end
    
  end

  def create_fast
    @user = User.create(name:params[:name],email:params[:email],address:params[:address],postal_code:params[:postal_code],pass:params[:pass])
    #respond_to do |format|
    #format.html { redirect_to @user, notice: "User was successfully re-created." }
    #format.json { head :no_content }
    #end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:user).permit(:email, :name, :birthday, :address, :postal_code,:pass,:id,)
    end
end
