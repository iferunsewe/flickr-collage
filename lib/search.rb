require "./lib/search_flickr/version"
require 'flickraw'

module SearchFlickr
  extend self
  FlickRaw.api_key="920490d1b6ca2176925a316eb1ed4861"
  FlickRaw.shared_secret="3b152563356e4da4"

  def create_keywords_array
    keywords_array = []
    ARGV.each do|a|
      keywords_array << a
    end
    keywords_array
  end

  class FlickrApi
    def initialize(keywords)
      @keywords = keywords
    end

    def get_flickr_results
      @keywords.map do |keyword|

      end
    end
  end
end

SearchFlickr.create_keywords_array

# https://api.flickr.com/services - endpoint
