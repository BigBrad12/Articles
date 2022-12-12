class UsersController < ApplicationController

    before_action :set_user, only: [:edit, :update, :show]

    def new
        @user = User.new
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 6)
    end

    def show
        @user = User.find(params[:id])
        @articles = @user.articles.paginate(page: params[:page], per_page: 6)
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "Welcome, #{@user.username}, sign up successful"
            redirect_to @user
        else
            render 'new'
        end
    end

    def edit

    end

    def update
        if @user.update(user_params)
            flash[:notice] = "User updated successfully"
            redirect_to user_path
        else
            render 'edit'
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user 
        @user = User.find(params[:id])
    end
end