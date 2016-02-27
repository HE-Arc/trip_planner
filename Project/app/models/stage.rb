class Stage < ActiveRecord::Base

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
