require "test_helper"

class PollTest < ActiveSupport::TestCase
  def test_options
    poll = Poll.new({
      title: 'title',
      description: 'description',
      options: ['a', 's', 'd']
    })

    puts(poll.inspect)
  end
end
