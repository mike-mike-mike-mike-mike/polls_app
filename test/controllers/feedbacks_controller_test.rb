require 'test_helper'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  test 'feedback should not post with invalid input' do
    assert_no_difference 'Feedback.count', 'feedback was created with invalid input' do
      post '/api/feedbacks', params: { feedback: { name: '', comments: 'comment' } }
      post '/api/feedbacks', params: { feedback: { name: 'name', comments: '' } }
    end
  end

  test 'feedback should post with valid input' do
    assert_difference 'Feedback.count', 1, 'feedback was not created with valid input' do
      post '/api/feedbacks', params: { feedback: { name: 'name', comments: 'comment' } }
    end
  end
end
