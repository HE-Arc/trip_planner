class StageComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :stage #, :counter_cache => true

  attr_accessible :content
end
