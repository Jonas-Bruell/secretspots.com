require "test_helper"

class FlickrServicesTest < ActionDispatch::IntegrationTest
  def setup
    @flickr_service = FlickrServices.new
    @tags = "dog"
    @lat = 50.8503
    @lon = 4.3517
    @radius = 10
  end

  mock_search_response = {
      "photos" => {
        "photo" => [
          {
            "id" => "1",
            "owner" => { "username" => "john_doe" },
            "title" => { "_content" => "A beautiful dog" },
            "description" => { "_content" => "This is a photo of a dog" }
          }
        ]
      }
    }

    mock_photo_details_response = {
      "photo" => {
        "location" => { "latitude" => @lat, "longitude" => @lon },
        "owner" => { "username" => "john_doe" },
        "title" => { "_content" => "A beautiful dog" },
        "description" => { "_content" => "This is a photo of a dog" },
        "urls" => { "url" => [{ "_content" => "http://example.com/photo/1" }] }
      }
    }

    mock_photo_comments_response = {
      "comments" => {
        "comment" => [
          { "authorname" => "commenter1", "_content" => "Great photo!" },
          { "authorname" => "commenter2", "_content" => "Lovely dog!" }
        ]
      }
    }

  # Test Flickr photo search
  test "should return valid photo search results" do
    @flickr_service.stub :make_request, mock_search_response do
      response = @flickr_service.search_photos(@tags, @lat, @lon, @radius)
      assert response["photos"]
      assert_equal "A beautiful dog", response["photos"]["photo"].first["title"]["_content"]
      assert_equal "This is a photo of a dog", response["photos"]["photo"].first["description"]["_content"]
    end
  end

  # Test getting photo details
  test "should return valid photo details" do
    @flickr_service.stub :make_request, mock_photo_details_response do
      response = @flickr_service.get_photo_details("1")
      assert response["photo"]
      assert_equal "A beautiful dog", response["photo"]["title"]["_content"]
      assert_equal "http://example.com/photo/1", response["photo"]["urls"]["url"].first["_content"]
    end
  end

  # Test getting photo comments
  test "should return valid photo comments" do
    @flickr_service.stub :make_request, mock_photo_comments_response do
      response = @flickr_service.get_photo_comments("1")
      assert response["comments"]
      assert_equal "Great photo!", response["comments"]["comment"].first["_content"]
      assert_equal "Lovely dog!", response["comments"]["comment"].last["_content"]
    end
  end

  # Test combining all methods to search for valid photos and retrieve details
  test "should return valid photo details with comments" do
    @flickr_service.stub :make_request, mock_search_response do
      @flickr_service.stub :get_photo_details, mock_photo_details_response do
        @flickr_service.stub :get_photo_comments, mock_photo_comments_response do
          photo_details_list = search_valid_pics_and_data(@flickr_service, @tags, @lat, @lon, @radius)
          assert photo_details_list.any?
          assert_equal "A beautiful dog", photo_details_list.first[:title]
          assert_equal "commenter1: Great photo!", photo_details_list.first[:comments].first
          assert_equal "http://example.com/photo/1", photo_details_list.first[:photo_url]
        end
      end
    end
  end
end
