class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @events = if user_signed_in? && current_user.admin?
      Event.all
    elsif user_signed_in?
      Event.where(status: [:published, :finished, :ongoing, :cancelled])
          .or(Event.where(user: current_user))
    else
      Event.where(status: [:published, :finished, :ongoing, :cancelled])
    end
  end

  def show
  end

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.status = :draft
    @event.user = current_user
    authorize @event
    if @event.save
      redirect_to @event, notice: "Event created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @event
  end

  def update
    authorize @event
    if @event.update(event_params)
      redirect_to @event, notice: "Event updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @event
    @event.update(status: :cancelled)
    redirect_to events_path, notice: "Event cancelled."
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :start_date, :end_date, :capacity, :location, :venue_id, :status, category_ids: [])
  end
end