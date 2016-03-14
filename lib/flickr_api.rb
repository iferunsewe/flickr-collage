require 'rmagick'

module FlickIt
  extend self

  class FlickrApi
    include Magick

    def initialize(keywords=nil)
      @keywords = keywords
      @flickr_endpoint = 'https://api.flickr.com/services/rest/'
      @api_key = "920490d1b6ca2176925a316eb1ed4861"
      @default_query = {'api_key' => @api_key}
    end

    # Default request for flickr api
    def request_flickr_api(method, params={})
      puts "Requesting the flickr api request for the method #{method}"
      query = {"method" => method}.merge! params
      query.merge! @default_query
      response = HTTParty.post(@flickr_endpoint, :query => query)
      raise "The flickr api request for the method #{method} is returning a #{response.code} response code" unless response.code == 200
      response
    end

    # Api call for the search method in the flickr api
    def get_flickr_search_result(keyword)
      response = request_flickr_api('flickr.photos.search', {"tags" => keyword, "sort" => 'interestingness-desc'})
      photos = response["rsp"]["photos"]["photo"]
      if photos.nil?
        puts "Didn't find any photos for #{keyword}"
      else
        puts "Found some photos for #{keyword}"
      end
      photos
    end


    def sort_results(keyword_results = get_flickr_results)
      keyword_results.map! do |results|
        results.first
        # selected_id = results.max_by do |result|
        # end['id']
        # selected_id
      end
      keyword_results
    end

    def get_favourite(photo_id)
      request_flickr_api("flickr.photos.getFavorites", {"photo_id" => photo_id})
    end


    def get_total(photo_id)
      get_favourite(photo_id)['rsp']['photo']['total']
    end

    def download_photo_sizes(photo_id)
      request_flickr_api("flickr.photos.getSizes", {"photo_id" => photo_id})
    end
  end
end

