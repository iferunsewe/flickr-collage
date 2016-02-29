require "./lib/search_flickr/version"

module SearchFlickr
  extend self

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
