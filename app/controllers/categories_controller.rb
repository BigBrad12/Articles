class CategoriesController < ApplicationController

    def show
    end

    def new
        @category = Category.new 
    end

    def index
    end

    def create
        @category = Category.create(params.require(:category).permit(:name))
        if @category.save
            flash[:notice] = "Category was successfully added"
            redirect_to root_path
       else
            render 'new'
       end
    end

end