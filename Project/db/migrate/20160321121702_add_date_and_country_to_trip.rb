class AddDateAndCountryToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :date_start, :datetime
    add_column :trips, :date_end, :datetime
    add_column :trips, :main_country, :string
  end
end
