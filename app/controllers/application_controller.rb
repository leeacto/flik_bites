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
  
  def url_check(poss_url)
  	if poss_url[-1].to_i == 0
			poss_url[0..-2] + (poss_url[-1].chr.ord - 1).chr + "2"
		else
			poss_url
		end
  end
end
