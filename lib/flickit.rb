require './lib/flickit/version'
require './lib/flickr_api'
require './lib/keywords_controller'
require './lib/collage'
require 'active_support/all'
require 'flickraw'
require 'pry-byebug'
require 'httparty'
require 'rmagick'
require 'open-uri'

# @keywords_controller = FlickIt::KeywordsController.new(ARGV)
# @collage = FlickIt::Collage.new
#
# # photos = @keywords_controller.get_photos_for_keywords
# # @collage.create(photos)
# # @collage.delete_images