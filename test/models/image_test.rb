require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'should not save without a valid URL' do
    image = Image.new
    # no url yet
    assert_not image.save
    # url but invalid
    image.url = 'asdf'
    assert_not image.save, 'Image was saved with invalid URL'
    image.url = 'https://i2.wp.com/www.gamerfocus.co/wp-content/uploads/2018/09/donkey_kong_confused.png'
    assert image.save, 'Image was not saved, though URL was valid'
  end

  test 'should not update without a valid URL' do
    image = Image.new
    image.url = 'https://i2.wp.com/www.gamerfocus.co/wp-content/uploads/2018/09/donkey_kong_confused.png'
    image.save
    assert_not image.update(url: 'asdf'), 'Image was updated with invalid URL'
    assert image.update(url: 'https://images.unsplash.com/photo-1641236247214-2d5a33c6d391?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MzV8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
           'Image was not updated, though URL was valid'
  end

  test 'should be able to add tags' do
    image = Image.new
    image.url = 'https://i2.wp.com/www.gamerfocus.co/wp-content/uploads/2018/09/donkey_kong_confused.png'
    image.tag_list.add('tag 1, tag 2')
    assert image.save
  end
end
