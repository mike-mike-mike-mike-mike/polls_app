require "application_system_test_case"

class PollResponsesTest < ApplicationSystemTestCase
  setup do
    @poll_response = poll_responses(:one)
  end

  test "visiting the index" do
    visit poll_responses_url
    assert_selector "h1", text: "Poll responses"
  end

  test "should create poll response" do
    visit poll_responses_url
    click_on "New poll response"

    fill_in "Answer", with: @poll_response.answer
    fill_in "Poll", with: @poll_response.poll_id
    click_on "Create Poll response"

    assert_text "Poll response was successfully created"
    click_on "Back"
  end

  test "should update Poll response" do
    visit poll_response_url(@poll_response)
    click_on "Edit this poll response", match: :first

    fill_in "Answer", with: @poll_response.answer
    fill_in "Poll", with: @poll_response.poll_id
    click_on "Update Poll response"

    assert_text "Poll response was successfully updated"
    click_on "Back"
  end

  test "should destroy Poll response" do
    visit poll_response_url(@poll_response)
    click_on "Destroy this poll response", match: :first

    assert_text "Poll response was successfully destroyed"
  end
end
