require "test_helper"

class UserFilesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_files_index_url
    assert_response :success
  end

  test "should get create" do
    get user_files_create_url
    assert_response :success
  end

  test "should get destroy" do
    get user_files_destroy_url
    assert_response :success
  end

  test "should get download" do
    get user_files_download_url
    assert_response :success
  end

  test "should get toggle_public" do
    get user_files_toggle_public_url
    assert_response :success
  end
end
