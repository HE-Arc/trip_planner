class AddDateTimeToStage < ActiveRecord::Migration
  def change
    add_column :stages, :date_time, :datetime
  end
end
