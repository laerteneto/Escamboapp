class Site::HomeController < SiteController

  def index
  	@categories = Category.all.order_by_description
  	# Showing the last 6 ads added in the system. To see this function, go to models/ad.rb
  	@ads = Ad.descending_order(params[:page])
    @carousel = Ad.random(3)
  end

end
