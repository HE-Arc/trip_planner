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

  def maptrip

    if !params.has_key?(:id)
      trip = Trip.first
    else
      trip = Trip.find(params[:id])
    end

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
        flash.notice = t('trip_creation_success')
        redirect_to action: :index
      else
        flash.alert = @trip.errors.full_messages
        redirect_to action: :new
      end
    else
      flash.alert = t('trip_creation_not_connected')
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
          flash.notice = t('trip_edition_success')
          else
            render 'edit'
        end
      else
        flash.alert = t('trip_edition_not_owner')
      end
    else
      flash.alert = t('trip_edition_not_connected')
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
        flash.notice = t('trip_removal_success')
      else
        flash.alert = t('trip_removal_not_owner')
      end
    else
      flash.alert = t('trip_removal_not_connected')
    end
    redirect_to action: :index
  end

  def trip_params
    params.require(:trip).permit(:title, :description, :image)
  end

end