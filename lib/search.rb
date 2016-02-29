require "./lib/search_flickr/version"
require 'flickraw'
require 'pry-byebug'

module SearchFlickr
  extend self
  FlickRaw.api_key= "920490d1b6ca2176925a316eb1ed4861"
  FlickRaw.shared_secret= "3b152563356e4da4"

  def create_keywords_array
    keywords_array = []
    ARGV.each do|a|
      keywords_array << a
    end
    puts "Created keywords array"
    keywords_array
  end

  class FlickrApi
    def initialize(keywords)
      @keywords = keywords
    end

    def get_flickr_results
      @keywords.map do |keyword|
        search_results = flickr.photos.search(tags: keyword)
        p "Got flickr results for #{keyword}"
        search_results
      end

    end

    def sort_results(keyword_results = get_flickr_results)
      keyword_results.map do |results|
        binding.pry
        results.sort_by do |result|
          flickr.photos.getFavorites(photo_id: result.id).total
        end.last
      end
      p "KEYWORD RESULTS ----------------- #{keyword_results}"
    end


  end
end

keywords = SearchFlickr.create_keywords_array
SearchFlickr::FlickrApi.new(keywords).sort_results

# https://api.flickr.com/services - endpoint
