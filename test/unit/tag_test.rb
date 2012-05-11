require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should set tags" do
    record = Page.first
    record.tag_list = "one, two, three"
    record.save

    assert_equal 3, Tagging.where(:resource_type => record.class.to_s, :resource_id => record.id).count
    assert_equal 1, Tag.where(:title => "one").count

    record.tag_list = "one, two"
    record.save

    assert_equal 2, Tagging.where(:resource_type => record.class.to_s, :resource_id => record.id).count
    assert_equal 1, Tag.where(:title => "one").count

    record.tag_list = "two, four, six"
    record.save

    assert_equal 3, Tagging.where(:resource_type => record.class.to_s, :resource_id => record.id).count
    assert_equal 1, Tag.where(:title => "one").count
  end

  test "should set tags upon creation" do
    record = Page.new(:domain_id => 1, :user_id => 1, :title => "test")
    record.tag_list = "one, two, three"

    assert_equal 0, Tagging.where(:resource_type => record.class.to_s, :resource_id => record.id).count
    assert_equal 0, Tag.where(:title => "one").count

    record.save

    assert_equal 3, Tagging.where(:resource_type => record.class.to_s, :resource_id => record.id).count
    assert_equal 1, Tag.where(:title => "one").count
  end

end
