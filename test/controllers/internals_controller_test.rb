require 'test_helper'

class InternalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get internals_index_url
    assert_response :success
  end

  test "should get new" do
    get internals_new_url
    assert_response :success
  end

  test "should get edit" do
    get internals_edit_url
    assert_response :success
  end

end
