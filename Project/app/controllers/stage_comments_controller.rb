class StageCommentsController < ApplicationController

  def create
    if current_user != nil
      @stage_comment = StageComment.new(params[:stage_comment])

      if params[:stage_id]
        @stage = Stage.find(params[:stage_id])
      end

      @stage_comment.stage = @stage
      @stage_comment.user = current_user

      if @stage_comment.save
        flash.notice = t('stage_comment_success')
        redirect_to :back
      else
        flash.alert = @trip.errors.full_messages
        redirect_to action: :new
      end
    else
      flash.alert = t('trip_creation_not_connected')
      redirect_to action: :index
    end
  end

  def stage_list
    @stage_comment = StageComment.where(:stage_id => params[:stage_id])
  end

  def new
    @stage_comment = StageComment.new

    @trip = nil
    if params[:trip_id]
      @trip = Trip.find(params[:trip_id])
    end

    @stage = nil
    if params[:stage_id]
      @stage = Stage.find(params[:stage_id])
    end

  end

  def index
    @stage_comment = StageComment.all
  end

  def show
    @stage_comment = StageComment.find(params[:id])
  end

  def stage_comments_params
    params.require(:stage_comments_params).permit(:content, :stage_id)
  end

end
