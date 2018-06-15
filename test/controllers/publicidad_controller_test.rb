require 'test_helper'

class PublicidadControllerTest < ActionDispatch::IntegrationTest
  test "should get mantenimiento" do
    get publicidad_mantenimiento_url
    assert_response :success
  end

end
