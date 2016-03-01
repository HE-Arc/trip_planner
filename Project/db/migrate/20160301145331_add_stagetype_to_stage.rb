class AddStagetypeToStage < ActiveRecord::Migration
  def change
    add_reference :stages, :stagetype, index: true, foreign_key: true
  end
end
