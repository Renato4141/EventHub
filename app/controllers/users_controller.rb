class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.includes(:events, :registrations, :reviews).find(params[:id])
  end
end
