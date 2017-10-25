class Site::AdDetailController < SiteController
	layout "site"

    def show
    	@ad = Ad.find(params[:id])
        @categories = Category.all.order_by_description
    end

end
