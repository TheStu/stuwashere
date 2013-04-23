module GetFlickr
  require 'flickraw'

  FlickRaw.api_key=ENV['FLICKR_KEY']
  FlickRaw.shared_secret=ENV['FLICKR_SECRET']

  def update_flickr_urls(picture_model)
    /(\d*)\/\z/.match(picture_model.flickr_url)
    info = flickr.photos.getInfo(:photo_id => $1)
    small_pic_url = FlickRaw.url_s(info)
    medium_pic_url = FlickRaw.url(info)
    large_pic_url = FlickRaw.url_b(info)
    picture_model.update_attributes(:flickr_small_url => small_pic_url,
                                    :flickr_medium_url => medium_pic_url,
                                    :flickr_large_url => large_pic_url,)
  end
end
