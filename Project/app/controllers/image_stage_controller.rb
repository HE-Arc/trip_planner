class ImageStageController < ApplicationController

  def destroy
    imagestage = ImageStage.find(params[:id])

    stageid = imagestage.stage.id
    tripid = imagestage.stage.trip.id
    imagestage.destroy

    redirect_to edit_trip_stage_path(tripid, stageid)
  end

end
