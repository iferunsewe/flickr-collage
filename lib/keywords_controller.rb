module SearchFlickr
  class KeywordsController
    def initialize
      @flickr_api = FlickrApi.new
    end

    def get_photos_for_keywords
      keywords = ARGV.map do |keyword|
        puts "Getting photos for #{keyword}"
        photo_results = @flickr_api.get_flickr_search_result(keyword)
        if photo_results.nil?
          puts "No photos found for #{keyword}"
          photo_results = get_random_keyword_photos
        end
        photo_results.first
      end
      fill_keywords_array(keywords)
    end

    private

    def fill_keywords_array(keywords)
      missing_keywords = 10 - keywords.length
      puts "Filling the keywords array with photos for #{missing_keywords} keywords"
      if missing_keywords != 0
        missing_keywords.times do
          keywords << get_random_keyword_photos.first
        end
      end
      keywords
    end

    def random_word
      open('/usr/share/dict/words').read.split(/\n/).sample
    end

    def get_random_keyword_photos
      puts "Finding photos for a random word"
      random_photo_result = @flickr_api.get_flickr_search_result(random_word) until random_photo_result.present? &&
          random_photo_result.first.class == Hash &&
          (['farm', 'server', 'secret'].any? do |key|
            random_photo_result.first.key?(key)
          end)
      random_photo_result
    end
  end
end
