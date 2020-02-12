module SessionsHelper
  #login with giving id
  def log_in(user)
    session[:user_id] = user.id
  end 
  
  #return the current user(if it is)
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  #log out the current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end