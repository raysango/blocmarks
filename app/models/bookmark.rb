class Bookmark < ActiveRecord::Base
  validates :url, presence: true
  belongs_to :topic
  has_many :likes, dependent: :destroy
  after_create :set_embedly_url
  before_save :normalize_url
  
  private 
  
  def normalize_url
    self.url = url.include?("http://") ? url : "http://#{url}"
  end
  
  def set_embedly_url
  embedly_api = Embedly::API.new :key => ENV['EMBEDLY_API_KEY'],:maxwidth => 550,
  :wmode => 'transparent',
        :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'

  Rails.logger.info ">>>> embedly object: #{embedly_api.inspect}"
    
    obj = embedly_api.extract :url => self.url
  # get result and find the attribute for the thumbnail_url
  # set the bookmark's thumbnail_url with that value -- update_attribute(thumbnail_url: val_of_thumbnail_url_from_response)
  o = obj.first
    if o.images != []
  image = o.images.first
  update_attribute(:thumbnail_url, image['url'])
    end
 end
end
