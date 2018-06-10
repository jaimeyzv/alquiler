require 'test_helper'

class Controlador1ControllerTest < ActionDispatch::IntegrationTest
  test "should get vista1" do
    get controlador1_vista1_url
    assert_response :success
  end

end
