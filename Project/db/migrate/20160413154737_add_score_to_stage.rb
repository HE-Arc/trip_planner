class AddScoreToStage < ActiveRecord::Migration
  def change
    add_column :stages, :score, :int
  end
end
