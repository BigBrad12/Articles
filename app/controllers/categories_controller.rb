class CategoriesController < ApplicationController
    
    before_action :set_category, only: [:show, :edit, :update]
    before_action :require_admin, except: [:index, :show]
    def show
        @category = Category.find(params[:id])
        @articles = @category.articles.paginate(page: params[:page], per_page: 6)
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
    def edit
        
    end

    def update
        if @category.update(category_params)
            flash[:notice] = "Category has been updated"
            redirect_to category_path
        else
            render 'edit'
        end
    end
    private
        def category_params
            params.require(:category).permit(:name)
        end
        def set_category
            @category = Category.find(params[:id])
        end
        def require_admin
            if !(logged_in? && current_user.admin?)
                flash[:alert] = "You need to be an admin to do that"
                redirect_to categories_path
            end
        end
end