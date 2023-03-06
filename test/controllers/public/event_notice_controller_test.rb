require "test_helper"

class Public::EventNoticeControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_event_notice_new_url
    assert_response :success
  end
end
