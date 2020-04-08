require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get customers" do
    get companies_customers_url
    assert_response :success
  end

end
