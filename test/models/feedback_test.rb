require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  test 'should not save without name' do
    feedback = Feedback.new
    feedback.comments = 'comment'
    assert_not(feedback.save, 'Feedback was saved without name')
  end

  test 'should not save without comment' do
    feedback = Feedback.new
    feedback.name = 'name'
    assert_not(feedback.save, 'Feedback was saved without comment')
  end

  test 'should save with name and comment present' do
    feedback = Feedback.new
    feedback.name = 'name'
    feedback.comments = 'comment'
    assert(feedback.save, 'Feedback did not save with valid name/comment')
  end
end
