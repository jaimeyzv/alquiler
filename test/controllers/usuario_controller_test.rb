require 'test_helper'

class UsuarioControllerTest < ActionDispatch::IntegrationTest
  test "should get tipousuario" do
    get usuario_tipousuario_url
    assert_response :success
  end

end
