class AddTripToStages < ActiveRecord::Migration
  def change
    add_reference :stages, :trip, index: true, foreign_key: true
  end
end
