class Stage < ActiveRecord::Base

  belongs_to :trip
  belongs_to :stagetype

  has_many :image_stages, :dependent => :destroy

  validates :title,
            presence: true,
            length: {minimum: 0, maximum: 255}
  validates :description,
            length: {minimum: 0, maximum: 65535}
  validates :adress,
            length: {minimum: 0, maximum: 255}
  validates :date_time,
            presence: true
  validates :stagetype_id,
            presence: true

end
