class AddAttachmentImageToImageStages < ActiveRecord::Migration
  def self.up
    change_table :image_stages do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :image_stages, :image
  end
end
