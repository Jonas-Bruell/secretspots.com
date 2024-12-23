require 'net/http'
require 'json'

=begin
secret sports
Key:
e2f396329e683d393330d1117a898bcc

Secret:
db2593e4b2524b2e
=end

class FlickrServices
  BASE_URL = "https://api.flickr.com/services/rest/"

  def initialize # fix env
    @api_key = "e2f396329e683d393330d1117a898bcc" # Rails.application.credentials.dig('FLICKR_API_KEY')
    @secret_key = "db2593e4b2524b2e" # Rails.application.credentials.dig('FLICKR_SECRET_KEY')
  end

  def search_photos(tags, lat, lon, radius = 5, per_page = 5)
    params = {
      method: "flickr.photos.search",
      api_key: @api_key,
      tags: tags,
      format: "json",
      nojsoncallback: 1,
      lat: lat,
      lon: lon,
      radius: radius,
      per_page: per_page
    }
    make_request(params)
  end

  def get_photo_details(photo_id)
    params = {
      method: "flickr.photos.getInfo",
      api_key: @api_key,
      format: "json",
      nojsoncallback: 1,
      photo_id: photo_id
    }
    make_request(params)
  end

  def get_photo_comments(photo_id)
    params = {
      method: "flickr.photos.comments.getList",
      api_key: @api_key,
      format: "json",
      nojsoncallback: 1,
      photo_id: photo_id
    }
    response = make_request(params)
    if response && response["comments"] && response["comments"]["comment"]
      response["comments"]["comment"].map { |comment| { author: comment["authorname"], content: comment["_content"] } }
    else
      []
    end
  end

  def get_image_url(photo_id)
    params = {
      method: "flickr.photos.getSizes",
      api_key: @api_key,
      photo_id: photo_id,
      format: "json",
      nojsoncallback: 1
    }
    response = make_request(params)
    if response && response["sizes"] && response["sizes"]["size"]
      sizes = response["sizes"]["size"]

      original_size = sizes.find { |size| size["label"] == "Original" }
      if original_size
        original_size["source"]
      else
        last_size = sizes.last
        last_size["source"]
      end
    else
      puts "Error: Invalid response from API."
      nil
    end
  end

  private

  def make_request(params)
    uri = URI(BASE_URL)
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  rescue StandardError => e
    Rails.logger.error "Flickr API Error: #{e.message}"
    nil
  end
end

def search_valid_pics_and_data(flickr, tags, lat, lon, radius = 5, per_page = 5)
  photos_response = flickr.search_photos(tags, lat, lon, radius, per_page)
  if photos_response && photos_response["photos"] && photos_response["photos"]["photo"].any?
    valid_photos = []
    photos_response["photos"]["photo"].each do |photo|
      photo_details = flickr.get_photo_details(photo["id"])
      if photo_details && photo_details["photo"] && photo_details["photo"]["location"]
        location = photo_details["photo"]["location"]
        username = photo_details["photo"]["owner"]["username"]
        title = photo_details["photo"]["title"]["_content"]
        description = photo_details["photo"]["description"]["_content"]
        if location["latitude"] && location["longitude"]
          valid_photos << {
            photo: photo,
            latitude: location["latitude"],
            longitude: location["longitude"],
            username: username,
            title: title,
            description: description
          }
        end
      end
    end

    if valid_photos.any?
      photo_details_list = []

      valid_photos.each_with_index do |photo_data, index|
        photo = photo_data[:photo]
        photo_id = photo["id"]
        username = photo_data[:username]
        latitude = photo_data[:latitude]
        longitude = photo_data[:longitude]
        title = photo_data[:title]
        description = photo_data[:description]

        photo_url = flickr.get_image_url(photo_id)
        comments = flickr.get_photo_comments(photo_id)
        photo_details = flickr.get_photo_details(photo_id)
        post_url = photo_details && photo_details["photo"]["urls"]["url"] ? photo_details["photo"]["urls"]["url"].find { |url| url["_content"].include?("http") }["_content"] : "No URL found"

        photo_details_list << {
          photo_number: index + 1,
          title: title,
          description: description,
          username: username,
          post_url: post_url,
          photo_url: photo_url,
          geo_location: { latitude: latitude, longitude: longitude },
          comments: comments
        }
      end
      photo_details_list
    else
      puts "No valid photos found with geo-location."
      []
    end
  else
    puts "No photos found."
    []
  end
end

# not needed once data can be put in real post and comment
def print_photo_details(photo_details_list)
  if photo_details_list.any?
    photo_details_list.each_with_index do |photo_data, index|
      puts "Photo #{photo_data[:photo_number]}:"
      puts "Title: #{photo_data[:title]}"
      puts "Description: #{photo_data[:description]}"
      puts "Author: #{photo_data[:username]}"
      puts "Post URL: #{photo_data[:post_url]}"
      puts "Photo URL: #{photo_data[:photo_url]}"
      puts "Geo Location: #{photo_data[:geo_location][:latitude]}, #{photo_data[:geo_location][:longitude]}"

      if photo_data[:comments].any?
        puts "Comments:"
        photo_data[:comments].each do |comment|
          puts "#{comment[:author]}: #{comment[:content]}"
        end
      end

      puts "-" * 100
    end
  else
    puts "No valid photos found with geo-location."
  end
end


flickr_service = FlickrServices.new

tags = "cat"
lat = 50.8503
lon = 4.3517
radius = 10
results = 3

photo_details_list = search_valid_pics_and_data(flickr_service, tags, lat, lon, radius, results)
print_photo_details(photo_details_list)
