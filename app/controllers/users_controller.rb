class UsersController < ApplicationController

    before_action :set_user

    def settings
    end

    def create

        @user = User.new(user_params)

        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
        else
            redirect_to register_path
        end
        
    end

    private

    def set_user
        @user = User.find_by(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :password)
    end

end