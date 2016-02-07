class Admin::UsersController < ApplicationController
#before_filter :redirect_if_not_admin, except: [:create, :destroy]
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show 
    @user = User.find(params[:id])
  end

  def new 
    @user = User.new 
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      render :new 
    end
  end

  def destroy
    @user = User.find(params[:id])
    UserMailer.goodbye_email(@user).deliver
    @user.destroy
    nil_session
    flash[:success] = "User deleted"
    redirect_to movies_path
    puts "USER DELETED FROM ADMIN"
  end

  def edit
    @user = User.find(params[:id])
  end

  def update 
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to movies_path, notice: "#{@user.firstname} was updated successfully!"
    else
      render :edit
    end
  end

  protected

  def user_params
     params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admincode)
  end

end