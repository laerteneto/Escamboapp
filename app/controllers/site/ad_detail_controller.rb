class Site::AdDetailController < SiteController
	layout "site"

    def show
    	@ad = Ad.find(params[:id])
        @categories = Category.all.order_by_description

        respond_to do |format|
            format.html #views htaml.erb
            format.json { render json: @ad, except: [:description, :description_md]}
            format.xml { render xml: @ad }
        end
    end

end
