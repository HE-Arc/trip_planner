class Stage < ActiveRecord::Base

  belongs_to :trip
  belongs_to :stagetype

  has_many :image_stages, :dependent => :delete_all
  has_many :stage_comments, :dependent => :delete_all

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
