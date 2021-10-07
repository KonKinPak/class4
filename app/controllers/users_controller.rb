class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy edit2 post newPost ] 
  before_action :logged_in, except: %i[main index log_in new create show  edit destroy update create_fast]
  #before_action(:set_user, only: [:show, :edit, :update, :destroy])
  #do function set user before do
  def main
    session[:user_id] = nil
  end
  def log_in
    @email = params[:email]
    @pass = params[:password]
    @user = User.find_by(email:@email)
    #@user.pass == params[:pass]
    unless(@user.present? && @user.authenticate(@pass))
      redirect_to main_path , alert: "Email/password not valid"
    else
      session[:user_id] = @user.id
      redirect_to show3_path, notice: "Login successfully"
    end
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
    #@email = params[:email]
    #@pass = params[:password]
    @user = User.find(session[:user_id])
    #@user.pass == params[:pass]
    #unless(@user.present? && @user.authenticate(@pass))
    #  redirect_to main_path , alert: "Email/password not valid"
    #else
    #  session[:user_id] = @user.id
    #end
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
    puts session[:user_id]
    puts params[:id]
    unless(session[:user_id].to_s == params[:id].to_s)
      redirect_to show3_path, notice: "That's not your id"
    else
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
  end

  def update2
    @user = User.find(params[:user][:id])
    respond_to do |format|
      if @user.update(user_params)
        #redirect_to = go to url user
        format.html do
         #redirect_to "/show3?email=#{@user.email}&pass=#{@user.password}", notice: "User was successfully updated." 
         redirect_to show3_path, notice: "User was successfully updated." 
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
  #def updatePost
  #  @user = User.find(params[:post][:user_id])
  #  @post = @user.posts.find(params[:post][:id])
  #  respond_to do |format|
  #    if @post.update(post_params)
  #     #redirect_to = go to url user
  #      format.html do
  #       redirect_to "/show3?email=#{@user.email}&pass=#{@user.pass}", notice: "Post was successfully updated." 
  #     end
  #      format.json { render :show, status: :ok, location: @user }
  #    else
  #      format.html { render :edit, status: :unprocessable_entity }
  #      format.json { render json: @user.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  #def destroyPost
  #  @user = User.find(params[:uid])
  #  @post = @user.posts.find(params[:pid])
  # @post.destroy
  #  respond_to do |format|
  #    format.html { redirect_to "/show3?email=#{@user.email}&pass=#{@user.pass}", notice: "Post was successfully destroyed." }
  #    format.json { head :no_content }
  #  end
  #end

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
    @user = User.create(name:params[:name],email:params[:email],password:"1234")

    #respond_to do |format|
    #format.html { redirect_to @user, notice: "User was successfully re-created." }
    #format.json { head :no_content }
    #end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def logged_in
      if(session[:user_id])
        return true
      else
        redirect_to main_path, notice: "Please Login"
      end
    end
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name, :birthday, :address, :postal_code,:password,:id)
    end

    #def post_params
    #  params.require(:post).permit(:msg, :id, :user_id)
    #end
end
