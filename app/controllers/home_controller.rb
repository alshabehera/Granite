# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user_using_x_auth_token
  def index
    render
  end

  def create
    @user = User.find_by!(email: login_params[:email].downcase)
    unless @user.authenticate(login_params[:password])
      render_error("Incorrect credentials, try again.", :unauthorized)
    end
  end

  private

    def login_params
      params.require(:login).permit(:email, :password)
    end
end
