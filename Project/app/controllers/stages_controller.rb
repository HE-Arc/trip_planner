class StagesController < ApplicationController

  before_action :get_trip , only: [:create, :destroy, :edit, :update]
  before_action :identificate_user , only: [:create, :destroy, :edit]


  def identificate_user

    if !user_signed_in? || current_user != @trip.user
      flash[:notice] = t('you_havent_perm')
      redirect_to @trip
    end

  end

  def get_trip
    @trip = nil
    if params[:trip_id]
      @trip = Trip.find(params[:trip_id])
    end
  end


  def create
    @stage = Stage.new(stage_params)
    @stage.trip = @trip
    if @stage.save

      if params[:images]
        params[:images].each { |image|
          @stage.image_stages.create(image: image)
        }
      end


      redirect_to @trip
    else
      flash[:alerts] = @stage.errors.full_messages

      @my_stages = @trip.stages.order(:date_time).reverse_order
      render template: "trips/show"
    end
  end

  def destroy
    stage = Stage.find(params[:id])
    stage.destroy
    redirect_to @trip
  end

  def edit
    @stage = Stage.find(params[:id])
  end

  def update
    stage = Stage.find(params[:id])

    if params[:images]
      params[:images].each { |image|
        stage.image_stages.create(image: image)
      }
    end


    if stage.update_attributes(stage_params)
      # Handle a successful update.
      redirect_to @trip
    else
      render 'edit'
    end

  end

  def stage_params
    params.require(:stage).permit([:title, :description, :adress, :date_time, :trip_id, :image, :stagetype_id])
  end

end
