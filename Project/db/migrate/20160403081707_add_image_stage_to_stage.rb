class AddImageStageToStage < ActiveRecord::Migration
  def change
    add_reference :image_stages, :stage, index: true, foreign_key: true
  end
end
