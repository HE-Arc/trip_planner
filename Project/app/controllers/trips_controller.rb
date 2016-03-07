class TripsController < ApplicationController

  def index
    @trips = Trip.all
  end

  def user_list
    @trips = Trip.where(:user_id => params[:id])
  end

  def show
    @trip = Trip.find(params[:id])
    @stage = Stage.new
    @myStages = @trip.stages.order(:date_time).reverse_order
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new()
    @trip.title = params[:title]
    @trip.description = params[:description]
    @trip.user = current_user
    if @trip.save
      flash.notice = "Win!"
      redirect_to action: :index
    else
      flash.alert = @trip.errors.full_messages
      redirect_to action: :new
    end
  end

  def update
    redirect_to action: :index
  end

  def destroy
    @trip = Trip.find(params[:id])
    if current_user != nil
      if current_user.id == @trip.user_id
        @trip.stages.each do |stage|
          stage.delete
        end
        Trip.find(params[:id]).delete
        flash.notice = "Deleted"
      else
        flash.alert = "Not your trip"
      end
    else
      flash.alert = "Not connected"
    end
    redirect_to action: :index
  end

end