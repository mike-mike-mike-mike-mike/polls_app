require "test_helper"

class PollResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @poll_response = poll_responses(:one)
  end

  test "should get index" do
    get poll_responses_url
    assert_response :success
  end

  test "should get new" do
    get new_poll_response_url
    assert_response :success
  end

  test "should create poll_response" do
    assert_difference("PollResponse.count") do
      post poll_responses_url, params: { poll_response: { answer: @poll_response.answer, poll_id: @poll_response.poll_id } }
    end

    assert_redirected_to poll_response_url(PollResponse.last)
  end

  test "should show poll_response" do
    get poll_response_url(@poll_response)
    assert_response :success
  end

  test "should get edit" do
    get edit_poll_response_url(@poll_response)
    assert_response :success
  end

  test "should update poll_response" do
    patch poll_response_url(@poll_response), params: { poll_response: { answer: @poll_response.answer, poll_id: @poll_response.poll_id } }
    assert_redirected_to poll_response_url(@poll_response)
  end

  test "should destroy poll_response" do
    assert_difference("PollResponse.count", -1) do
      delete poll_response_url(@poll_response)
    end

    assert_redirected_to poll_responses_url
  end
end
