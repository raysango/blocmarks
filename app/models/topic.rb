class Topic < ActiveRecord::Base
  validates :title, presence: true
  validates_uniqueness_of :title
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
end
