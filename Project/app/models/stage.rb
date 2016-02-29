class Stage < ActiveRecord::Base

  has_attached_file :image, styles: { medium: "300x300>", small: "133x100", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :trip

  validates :title,
            presence: true,
            length: {minimum: 0, maximum: 255}
  validates :description,
            length: {minimum: 0, maximum: 65535}
  validates :adress,
            length: {minimum: 0, maximum: 255}
  validates :date_time,
            presence: true

end
