class CreateStageComments < ActiveRecord::Migration
  def change
    create_table :stage_comments do |t|
      t.text :content
      t.integer :nb_update
      t.references :user, index: true, foreign_key: true
      t.references :stage, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
