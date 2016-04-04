class CreateImageStages < ActiveRecord::Migration
  def change
    create_table :image_stages do |t|

      t.timestamps null: false
    end
  end
end
