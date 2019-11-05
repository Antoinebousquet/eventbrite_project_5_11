class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: :new

  # GET /events
  def index
    @events = Event.all
  end

  # GET /events/1
  def show
    @event = Event.find(params[:id])
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    @event = Event.new(
      'start_date' => params[:start_date],
      'duration' => params[:duration],
      'title' => params[:title],
      'description' => params[:description],
      'price' => params[:price],
      'location' => params[:location],
      'host_id' => current_user.id)
    if @event.save
      redirect_to event_path(current_user.hosted_events.last), notice: 'Success'
    else
      render 'new', notice: 'Fail'
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      flash.now[:danger] = 'Event could not be updated - please check your input.'
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :start_date, :duration, :description, :price, :location)
    end
end
