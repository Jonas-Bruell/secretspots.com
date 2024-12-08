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
    @api_key = 'e2f396329e683d393330d1117a898bcc' # ENV['FLICKR_API_KEY']
    @secret_key = 'db2593e4b2524b2e' # ENV['FLICKR_SECRET_KEY']
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
    make_request(params)
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
        puts "Error: Original size not found."
        nil
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

# temp testing code
flickr_service = FlickrServices.new

lat = 50.8503
lon = 4.3517
radius = 10
tags = "cat"

photos_response = flickr_service.search_photos(tags, lat, lon, radius)

if photos_response && photos_response["photos"] && photos_response["photos"]["photo"].any?
  valid_photos = []
  photos_response["photos"]["photo"].each do |photo|
    photo_details = flickr_service.get_photo_details(photo["id"])
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
    valid_photos.each_with_index do |photo_data, index|
      photo = photo_data[:photo]
      photo_id = photo["id"]
      username = photo_data[:username]
      latitude = photo_data[:latitude]
      longitude = photo_data[:longitude]
      title = photo_data[:title]
      description = photo_data[:description]

      photo_url = flickr_service.get_image_url(photo_id)

      comments_response = flickr_service.get_photo_comments(photo_id)

      photo_details = flickr_service.get_photo_details(photo_id)
      post_url = photo_details && photo_details["photo"]["urls"]["url"] ? photo_details["photo"]["urls"]["url"].find { |url| url["_content"].include?("http") }["_content"] : "No URL found"

      comments = comments_response && comments_response["comments"] && comments_response["comments"]["comment"] ? comments_response["comments"]["comment"].map { |comment|
        "#{comment["authorname"]}: #{comment["_content"]}"
      } : []

      puts "Photo #{index + 1}:"
      puts "Title: #{title}"
      puts "Description: #{description}"
      puts "Author: #{username}"
      puts "Post URL: #{post_url}"
      puts "Photo URL: #{photo_url}"
      puts "Geo Location: #{latitude}, #{longitude}"
      if comments.any?
        puts "Comments:"
        comments.each { |comment| puts comment }
      end
      puts "-" * 100
    end
  else
    puts "No valid photos found with geo-location."
  end
else
  puts "No photos found."
end
