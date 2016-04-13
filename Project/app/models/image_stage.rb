class ImageStage < ActiveRecord::Base

  belongs_to :stage
  has_attached_file :image, styles: { big: "900x600>", small: "200x150#", thumb: "64x48#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

end
