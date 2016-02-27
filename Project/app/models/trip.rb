class Trip < ActiveRecord::Base
  has_many :stages
end
