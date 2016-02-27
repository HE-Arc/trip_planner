class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
