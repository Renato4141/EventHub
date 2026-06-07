class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.includes(:events, :registrations, :reviews).find(params[:id])
    authorize @user
  end
end