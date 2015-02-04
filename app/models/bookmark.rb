class Bookmark < ActiveRecord::Base
  validates :url, presence: true
  belongs_to :topic
end
