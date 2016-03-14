module FlickIt
  class Collage
    def initialize
      @image = Magick::Image
      @image_list = Magick::ImageList.new
    end

    # Collates all of the images and creates collage
    def create(photos)
      added_local_image_files = add_local_image_files(photos)
      add_to_images_list(added_local_image_files)
      montage_it.write(ENV['HOME'] + '/Desktop/flickr_collage.jpg')
      puts "CREATED COLLAGE"
    end
    # Removes images from image folder 
    def delete_images
      FileUtils.rm_rf(Dir.glob('./lib/images/*'))
    end

    private


    # Creates local images from data in api
    def add_local_image_files(photos)
      photos.map do |photo|
        path = "./lib/images/#{photo['id']}.jpg"
        open(path, 'wb') do |file|
          file << open(create_photo_url(photo)).read
        end
        photo.merge!({'local_path' => open(path)})
      end
    end

    # Creates image url to get photo from
    def create_photo_url(photo)
      "http://farm#{photo['farm']}.static.flickr.com/#{photo['server']}/#{photo['id']}_#{photo['secret']}.jpg"
    end

    # Crops photo
    def crop(photo)
      @image.read(photo['local_path']).first.crop!(300, 400, 300, 400)
    end

    # Adds images to image list to use to create montage
    def add_to_images_list(photos)
      photos.each do |photo|
        img =  @image.read(photo['local_path']).first
        img.border!(30, 30, "#ffffff")
        @image_list << img
      end
      @image_list
    end

    # Creates montage and forms an image
    def montage_it(image_list = @image_list)
      photo_width = 250
      photo_height = 250
      padding_between_column = 0
      padding_between_row = 0
      montaged_image = image_list.montage do
        self.tile = "2x5"
        self.geometry = "#{photo_width}x#{photo_height}+#{padding_between_column}+#{padding_between_row}"
      end
      montaged_image.flatten_images
    end
  end
end