require "test_helper"

class Admin::CarsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_cars_index_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_cars_destroy_url
    assert_response :success
  end
end
