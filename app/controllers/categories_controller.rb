class CategoriesController < ApplicationController
    
    before_action :set_category, only: [:show]
    def show
       
    end

    def new
        @category = Category.new 
    end

    def index
        @categories = Category.all
    end

    def create
        @category = Category.create(category_params)
        if @category.save
            flash[:notice] = "Category was successfully added"
            redirect_to @category 
       else
            render 'new'
       end
    end
    private
        def category_params
            params.require(:category).permit(:name)
        end
        def set_category
            @category = Category.find(params[:id])
        end
end