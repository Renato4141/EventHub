class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @registrations = Registration.includes(:user, :event).all
  end

  def show
    authorize @registration
  end

  def create
    @event = Event.find(params[:registration][:event_id])
    @registration = Registration.new(user: current_user, event: @event)
    authorize @registration

    if @registration.save
      redirect_to @event, notice: "Successfully registered!"
    else
      redirect_to @event, alert: @registration.errors.full_messages.join(", ")
    end
  end

  def destroy
    authorize @registration
    @event = @registration.event

    if @registration.confirmed?
      first_waitlisted = @event.registrations.waitlisted.order(:created_at).first
      first_waitlisted&.update(status: :confirmed)
    end

    @registration.destroy
    redirect_to @event, notice: "Registration cancelled."
  end

  private

  def set_registration
    @registration = Registration.find(params[:id])
  end
end