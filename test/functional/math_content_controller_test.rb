require 'test_helper'

class MathContentControllerTest < ActionController::TestCase
  test "should get public" do
    get :public
    assert_response :success
  end

  test "should get students" do
    get :students
    assert_response :success
  end

  test "should get teachers" do
    get :teachers
    assert_response :success
  end

end
