class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def make_url(object, potential)
    id = object.id
    ob_class = object.class

    arr = ob_class.all.pluck(:url).compact
    arr = arr.grep /^#{potential}/
    
    if arr == []
      potential
    else
      poss_url = arr.sort.last.next
      url_check(poss_url)
    end
  end
  helper_method :make_url

  def url_check(poss_url)
    if poss_url[-1] =~ /[a-z]/
      poss_url[0..-2] + (poss_url[-1].chr.ord - 1).chr + "2"
    else
      poss_url
    end
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end
  helper_method :current_user

  # Returns true if current_user exists, false otherwise
  def logged_in?
    !current_user.nil?
  end
  helper_method :logged_in?
  
  def require_login(target_redirect = root_path)
    unless logged_in?
      flash[:error] = "Please log in first"
      redirect_to target_redirect
    end
  end

  def redirect_to_back(default = root_path)
    if !request.env["HTTP_REFERER"].blank? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back
    else
      redirect_to default
    end
  end
end
