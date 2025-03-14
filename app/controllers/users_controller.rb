# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    user.save!
    render_notice("User was successfully created!")
  end

  def index
    users = User.select(:id, :name)
    render status: :ok, json: { users: }
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
