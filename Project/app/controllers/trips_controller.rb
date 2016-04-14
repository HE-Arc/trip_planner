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
    @my_stages = @trip.stages.order(:date_time).reverse_order
  end

  def randtrip
    trip = Trip.first

    response = { :trip => trip, :stages => trip.stages, :user => trip.user }
    respond_to do |format|
      format.json  { render :json => response }
    end
  end

  def new
    @trip = Trip.new
  end

  def create
    if current_user != nil
      @trip = Trip.new(params[:trip])
      @trip.user = current_user

      if @trip.save
        flash.notice = "Win!"
        redirect_to action: :index
      else
        flash.alert = @trip.errors.full_messages
        redirect_to action: :new
      end
    else
      flash.alert = "Must be connected"
      redirect_to action: :index
    end
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    if current_user != nil
      @trip = Trip.find(params[:id])
      if current_user.id == @trip.user_id
        if @trip.update(params[:trip])
          flash.notice = "Win!"
          else
            render 'edit'
        end
      else
        flash.alert = "Cannot update someone else's trip"
      end
    else
      flash.alert = "Must be connected to edit a trip"
    end
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

  def trip_params
    params.require(:trip).permit(:title, :description)
  end

end