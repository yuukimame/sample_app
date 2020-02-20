module SessionsHelper
  #login with giving id
  def log_in(user)
    session[:user_id] = user.id
  end
  
  #make user session permanent
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  #return true, if giving user is logged in user
  def current_user?(user)
    user == current_user
  end
  
  #return the current user(if it is)
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  #delete permanent session
  def forget(user)
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  #log out the current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  #redirect back memoraize url (or default)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
  
  #store url is tried to access
  def store location
    session[:forwarding_url] = request.original_url if request.get?
  end
end