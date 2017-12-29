require 'test_helper'

class CellphonesControllerTest < ActionDispatch::IntegrationTest
  test "should get lines" do
    get cellphones_lines_url
    assert_response :success
  end

  test "should get devices" do
    get cellphones_devices_url
    assert_response :success
  end

  test "should get models" do
    get cellphones_models_url
    assert_response :success
  end

end
