class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def new
    @user = User.new
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      sign_in @user
      flash[:success] = "Поздравляю " + @user.name + " вы зарегистрированы!"
      redirect_to @user
    else
      render 'new'
    end
  end

   def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end

 def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Хочется что-то новенькое добавить в инфо?"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

  def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Пожалуйста зайдите под своим аккаунтом"
      end
    end

    def correct_user
      if current_user.id != params[:id].to_i
        redirect_to root_url, notice: "Хакеры не пройдут!"
      end
    end

   def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end


