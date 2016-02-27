class AddAdressToStage < ActiveRecord::Migration
  def change
    add_column :stages, :adress, :string
  end
end
