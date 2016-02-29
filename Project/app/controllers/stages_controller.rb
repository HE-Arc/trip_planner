class StagesController < ActionController::Base

  before_action :identificate_user , only: [:create]
  before_action :get_trip , only: [:create]

  def identificate_user
    #TODO : the user must be the owner of the trip to add / remove / edit stages
  end

  def get_trip
    @trip = nil
    if params[:trip_id]
      @trip = Trip.find(params[:trip_id])
    end
  end


  def create
    stage = Stage.new(stage_params)
    stage.trip = @trip
    if stage.save
      redirect_to @trip
    else
      flash[:alerts] = stage.errors.full_messages
      redirect_to @trip
    end
  end

  def stage_params
    params.require(:stage).permit([:title, :description, :adress, :date_time, :trip_id, :image])
  end

end
