require "/workspaces/www.secretspots.com/test/test_helper.rb"
require 'minitest/mock'
require 'ostruct'

class FlickrServicesTest < ActionDispatch::IntegrationTest
  def setup
    @flickr_service = FlickrServices.new
    @tags = "cat"
    @lat = 50.8503
    @lon = 4.3517
    @radius = 10
  end

  mock_search_response = OpenStruct.new(
  { "photos"=>{ "page"=>1, "pages"=>537, "perpage"=>1, "total"=>537,
  "photo"=>[ { "id"=>"53788075362", "owner"=>"38837659@N06", "secret"=>"db777d8f37", "server"=>"65535", "farm"=>66, "title"=>"Jumping Cat", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0 }] },
  "stat"=>"ok" })


  mock_photo_details_response = OpenStruct.new(
    { "photo"=>
      { "id"=>"53788075362",
      "owner"=>{ "username"=>"Wasfi Akab" },
      "title"=>{ "_content"=>"Jumping Cat" },
      "description"=>{ "_content"=>"a pretty jumping cat" },
      "location"=>{ "latitude"=>"50.792567", "longitude"=>"4.450617" },
      "urls"=>{ "url"=>[{ "_content"=>"https://www.flickr.com/photos/wasfiakab/53788075362/" }] } },
      "stat"=>"ok" })

  mock_photo_comments_response = [
    { author: "commenter1", content: "Great photo!" },
    { author: "commenter2", content: "Nice capture!" },
    { author: "commenter3", content: "Lovely cat" }]

  mock_get_image_url_response = "https://live.staticflickr.com/65535/53788075362_85bba35918.jpg"

  # Test Flickr photo search
  test "should return valid photo search results" do
    @flickr_service.stub :make_request, mock_search_response do
      response = @flickr_service.search_photos(@tags, @lat, @lon, @radius)
      assert response["photos"]
      assert_equal "53788075362", response["photos"]["photo"].first["id"]
      assert_equal "Jumping Cat", response["photos"]["photo"].first["title"]
    end
  end

  # Test getting photo details
  test "should return valid photo details" do
    @flickr_service.stub :make_request, mock_photo_details_response do
      response = @flickr_service.get_photo_details("1")
      assert response["photo"]
      assert_equal "Wasfi Akab", response["photo"]["owner"]["username"]
      assert_equal "Jumping Cat", response["photo"]["title"]["_content"]
      assert_equal "a pretty jumping cat", response["photo"]["description"]["_content"]
      assert_equal "50.792567", response["photo"]["location"]["latitude"]
      assert_equal "4.450617", response["photo"]["location"]["longitude"]
      assert_equal "https://www.flickr.com/photos/wasfiakab/53788075362/", response["photo"]["urls"]["url"].first["_content"]
    end
  end

# Test getting photo comments
test "should return valid photo comments" do
  @flickr_service.stub :make_request, mock_photo_comments_response do
    response = @flickr_service.get_photo_comments("1")
    assert response.is_a?(Array), "Response should be an array"
    assert_equal "Great photo!", response.first[:content]
    assert_equal "Lovely cat", response.last[:content]
    assert_equal "commenter1", response.first[:author]
    assert_equal "commenter3", response.last[:author]
  end
end

  test "should return valid photo details with comments" do
    @flickr_service.stub :search_photos, mock_search_response do
      @flickr_service.stub :get_photo_details, mock_photo_details_response do
        @flickr_service.stub :get_image_url, mock_get_image_url_response do
          @flickr_service.stub :get_photo_comments, mock_photo_comments_response do
            photo_details_list = search_valid_pics_and_data(@flickr_service, @tags, @lat, @lon, @radius)
            assert photo_details_list.any?, "No valid photos found"
            assert_equal "Jumping Cat", photo_details_list.first[:title]
            assert_equal "commenter1: Great photo!", photo_details_list.first[:comments].first
            assert_equal "https://live.staticflickr.com/65535/53788075362_85bba35918.jpg", mock_get_image_url_response
            assert_equal "Wasfi Akab", photo_details_list.first[:username]
            assert_equal "50.792567", photo_details_list.first[:geo_location][:latitude]
            assert_equal "4.450617", photo_details_list.first[:geo_location][:longitude]
          end
        end
      end
    end
  end
end
