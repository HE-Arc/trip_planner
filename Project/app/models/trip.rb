class Trip < ActiveRecord::Base
  has_many :stages
  belongs_to :user

  validates :title,
            presence: true,
            length: {minimum: 0, maximum: 255}
  validates :description,
            length: {minimum: 0, maximum: 65535}

end
