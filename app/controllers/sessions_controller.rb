class SessionsController < ApplicationController

  def new
  end
  

 def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Оппаньки! Что-то не то, проверьте все внимательнее!' 
      render 'new'
    end
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  def destroy
    sign_out
    redirect_to root_url
  end
end