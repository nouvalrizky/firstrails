class PasswordsController < ApplicationController

    before_action :require_user_logged_in!

    def edit
    end

    def update
        if Current.user.update(password_parrams)
            redirect_to edit_password_path, notice: "Password changed successfully!"
        else
            render :edit
        end
    end
    
    private

    def password_parrams
        params.require(:user).permit(:password, :password_confirmation)
    end
end