class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id 
      # this should attach order to user if signed in. 
      current_order.update(user_id:current_user.id) if current_user 
      #needs to work for buying things then signing in, or signing in then buying things
      redirect_to root_path, notice: "Hip Hipporay! You are now logged in as #{user.name}!"
    else
      render :new, notice: "Invalid email or password :("
    end
  end

  def destroy
    session[:user_id] = nil
    session[:order_id] = nil
    redirect_to root_path, notice: "You are now logged out! Hip Hop awaaaaaayyy!"
  end

end
