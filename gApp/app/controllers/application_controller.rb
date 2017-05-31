class ApplicationController < ActionController::Base
	before_action :getCategoryNav
	
  protect_from_forgery with: :exception

  def getCategoryNav
  	@сategoryNav = Category.all
  end
end
