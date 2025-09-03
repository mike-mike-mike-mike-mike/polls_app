require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest # rubocop:disable Metrics/ClassLength
  setup do
    Image.create(url: 'https://images.unsplash.com/photo-1641368894652-3363a32b5ee5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80',
                 tag_list: 'tag1, tag2')
    Image.create(url: 'https://images.unsplash.com/photo-1641367392721-a94e13e75e4d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8NXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
                 tag_list: 'tag2, tag3')
    Image.create(url: 'https://images.unsplash.com/photo-1641371633971-18ed69d25fe4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
                 tag_list: 'tag4')
    @image = Image.first
  end

  test 'should get index' do
    get images_url
    assert_response :success
  end

  test 'index should sort by created_at desc' do
    get images_url
    assert_select 'img' do |elements|
      assert_equal Image.count, elements.length, msg: 'incorrect number of images in index'
      elements.zip(Image.all.reverse).each do |element, test_image|
        assert_equal test_image.url, element.attributes['src'].to_s, 'images are out of order'
      end
    end
  end

  test 'tags are displayed on index' do
    get images_url
    assert_select 'div.tags_field', 3, 'incorrect number of tag fields'
    assert_select 'a.tag', 5 do |tags|
      assert_equal 'tag4', tags[0].inner_html, 'unexpected or no tag'
      assert_equal 'tag2', tags[1].inner_html, 'unexpected or no tag'
      assert_equal 'tag3', tags[2].inner_html, 'unexpected or no tag'
      assert_equal 'tag1', tags[3].inner_html, 'unexpected or no tag'
      assert_equal 'tag2', tags[4].inner_html, 'unexpected or no tag'
    end
  end

  test 'index can be filtered by tag' do
    get images_url(tag: 'tag2')
    assert_select 'img.image_display', 2, 'filter returned incorrect number of images'
    assert_select 'div.tags_field' do |tag_fields|
      tag_fields.each do |tag_field|
        assert tag_field.inner_html.include?('tag2'), 'image is not tagged with filter tag'
      end
    end
  end

  test 'images on index should be <= 400px' do
    get images_url
    assert_select 'img' do |elements|
      elements.each do |element|
        assert_equal 'image_display', element.attributes['class'].to_s,
                     'image not assigned `image_display` class'
      end
    end
  end

  test 'should get new' do
    get new_image_url
    assert_response :success
  end

  test 'should create image with valid URL' do
    new_url = 'https://images.unsplash.com/photo-1641147848858-ea36bb9cce25?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8NDV8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60'
    assert_no_difference 'Image.count', 'image was created with invalid URL' do
      post images_url, params: { image: { url: 'invalid url' } }
    end
    assert_difference 'Image.count', 1, 'image was not created' do
      post images_url, params: { image: { url: new_url } }
    end

    assert_redirected_to image_url(Image.last)
  end

  test 'should create image with tags' do
    new_url = 'https://images.unsplash.com/photo-1641147848858-ea36bb9cce25?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8NDV8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60'
    new_tag_list = 'tag a, tag b, tag c'
    assert_difference 'Image.count', 1, 'image not created' do
      post images_url, params: { image: { url: new_url, tag_list: new_tag_list } }
    end
    assert_equal new_tag_list, Image.last.tag_list.to_s
  end

  test 'should show image' do
    get image_url(@image)
    assert_response :success
  end

  test 'image on show page should be <= 400px' do
    get image_url(@image)
    assert_select 'img' do
      assert_select '[class=?]', 'image_display', msg: 'image not assigned `image_display` class'
    end
  end

  test 'show image should include tags' do
    get image_url(@image)
    assert_select 'a.tag', 2 do |tags|
      assert_equal 'tag1', tags[0].inner_html, 'missing tag on show page'
      assert_equal 'tag2', tags[1].inner_html, 'missing tag on show page'
    end
  end

  test 'should get edit' do
    get edit_image_url(@image)
    assert_response :success
  end

  test 'should update image with valid url' do
    update_url = 'https://images.unsplash.com/photo-1641247494318-5a7d3a445482?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8NDF8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60'
    patch image_url(@image), params: { image: { url: 'invalid url' } }
    assert_not_equal 'invalid url', @image.url, 'image updated with invalid URL'

    patch image_url(@image), params: { image: { url: update_url } }
    assert_redirected_to image_path(@image)
    @image.reload
    assert_equal update_url, @image.url, 'image not updated'
  end

  test 'should update tags' do
    # adds tags to the first image, which may or may not have existing tags
    new_tag_list = @image.tag_list.dup.add('tag 3', 'tag 4', 'asdf')
    patch image_url(@image), params: { image: { tag_list: new_tag_list.join(',') } }
    @image.reload
    assert_equal new_tag_list, @image.tag_list, 'tag list not updated'
  end

  test 'should destroy image' do
    assert_difference('Image.count', -1, 'article was not deleted') do
      delete image_url(@image) # this looks funky
    end

    assert_redirected_to images_url
  end

  test 'seed data should create 20 images' do
    assert_difference 'Image.count', 20, 'seed data did not create 20 images' do
      Rails.application.load_seed
    end
  end

  test 'each page should have a footer' do
    get images_url
    assert_select 'footer', 1, 'index did not have footer'
    get new_image_url
    assert_select 'footer', 1, 'new did not have footer'
    get image_url(@image)
    assert_select 'footer', 1, 'show did not have footer'
    get edit_image_url(@image)
    assert_select 'footer', 1, 'edit did not have footer'
  end
end
