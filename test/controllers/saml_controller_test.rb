require "test_helper"

class SamlControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get saml_index_url
    assert_response :success
  end

  test "should get acs" do
    get saml_acs_url
    assert_response :success
  end
end
