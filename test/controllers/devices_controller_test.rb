require 'test_helper'

class DevicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @device = devices(:one)
  end

  test "should get index" do
    get devices_url
    assert_response :success
  end

  test "should get new" do
    get new_device_url
    assert_response :success
  end

  test "should create device" do
    assert_difference('Device.count') do
      post devices_url, params: { device: { check_date: @device.check_date, details: @device.details, device_model_id: @device.device_model_id, failure: @device.failure, imei: @device.imei, is_personal: @device.is_personal, line_id: @device.line_id, state: @device.state } }
    end

    assert_redirected_to device_url(Device.last)
  end

  test "should show device" do
    get device_url(@device)
    assert_response :success
  end

  test "should get edit" do
    get edit_device_url(@device)
    assert_response :success
  end

  test "should update device" do
    patch device_url(@device), params: { device: { check_date: @device.check_date, details: @device.details, device_model_id: @device.device_model_id, failure: @device.failure, imei: @device.imei, is_personal: @device.is_personal, line_id: @device.line_id, state: @device.state } }
    assert_redirected_to device_url(@device)
  end

  test "should destroy device" do
    assert_difference('Device.count', -1) do
      delete device_url(@device)
    end

    assert_redirected_to devices_url
  end
end
