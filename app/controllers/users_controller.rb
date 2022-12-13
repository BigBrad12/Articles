class UsersController < ApplicationController

    before_action :set_user, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:show, :new, :create]
    before_action :require_same_user, only: [:dstroy, :edit, :update]

    def new
        @user = User.new
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 6)
    end

    def show
        @articles = @user.articles.paginate(page: params[:page], per_page: 6)
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome, #{@user.username}, sign up successful"
            redirect_to @user
        else
            render 'new'
        end
    end

    def destroy
            @user.destroy
            session[:user_id] = nil if @user == current_user
            flash[:notice] = "Account and articles have been deleted"
            redirect_to root_path
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

        def require_same_user
            if @user != current_user && !current_user.admin?
                flash[:alert] = "You're not allowed to do that"
                redirect_to @user
            end
        end
end