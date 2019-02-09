require 'test_helper'

class HogeControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get hoge_top_url
    assert_response :success
  end

end
