class TripsController < ApplicationController

  def index
    @trips = Trip.all
  end

  def user_list
    @trips = Trip.all #where(:user_id => 'params[:id_user]')
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
        flash.alert += @trip.errors.full_messages
        redirect_to action: :new
      end
  end

  def destroy
    redirect_to action: :index
  end

    def permitted_params
      params.permit trip: [:title, :description]
    end



end