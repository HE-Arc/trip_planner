class CreateStagetypes < ActiveRecord::Migration
  def change
    create_table :stagetypes do |t|
      t.string :title
      t.string :icon

      t.timestamps null: false
    end
  end
end
