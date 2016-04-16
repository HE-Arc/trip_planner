class Trip < ActiveRecord::Base
  has_many :stages
  belongs_to :user

  validates :title,
            presence: true,
            length: {minimum: 0, maximum: 255}
  validates :description,
            length: {minimum: 0, maximum: 65535}

  validates_uniqueness_of :title, :scope => :user_id

  attr_accessible :title, :description, :date_start, :date_end, :main_country, :image

  has_attached_file :image, styles: { big: "600x450#", medium: "150x150#", small: "80x80#"}, default_url: "/images/:style/trip_missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def country_name
    ISO3166::Country[main_country]
  end

end
