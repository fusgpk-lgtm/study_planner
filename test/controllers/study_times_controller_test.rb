require "test_helper"

class StudyTimesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get study_times_create_url
    assert_response :success
  end

  test "should get index" do
    get study_times_index_url
    assert_response :success
  end
end
