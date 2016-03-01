class StagesController < ActionController::Base

  before_action :identificate_user , only: [:create, :destroy, :edit]
  before_action :get_trip , only: [:create, :destroy, :edit, :update]

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

  def destroy
    stage = Stage.find(params[:id])
    stage.delete
    redirect_to @trip
  end

  def edit
    @stage = Stage.find(params[:id])
  end

  def update
    stage = Stage.find(params[:id])
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
