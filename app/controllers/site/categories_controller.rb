class Site::CategoriesController < SiteController

    def show
        @categories = Category.all.order_by_description
        @category = Category.friendly.find(params[:id])
        # Showing the last 6 ads added in the system. To see this function, go to models/ad.rb
        @ads = Ad.by_category(@category, params[:page])
    end

end
