class Stagetype < ActiveRecord::Base
  has_many :stages

  validates :title,
            presence: true
  validates :icon,
            presence: true
end
