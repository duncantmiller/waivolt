require "test_helper"

class InquiriesTest < ActionDispatch::IntegrationTest
  setup do
    @inquiry = inquiries(:one)
  end

  test "should get new" do
    get new_inquiry_url
    assert_response :success
  end

  test "should create inquiry" do
    assert_difference("Inquiry.count") do
      post inquiries_url, params: { inquiry: { contact_id: @inquiry.contact_id, email: @inquiry.email, name: @inquiry.name } }
    end

    assert_redirected_to inquiry_url(Inquiry.last)
  end

  test "should show inquiry" do
    get inquiry_url(@inquiry)
    assert_response :success
  end
end
