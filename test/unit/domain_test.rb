require 'test_helper'

class DomainTest < ActiveSupport::TestCase
  test "should give tags" do
    domain = Domain.first
    assert !domain.tags.nil?
  end

  test "should give tags for pages" do
    domain = Domain.first
    assert !domain.tags_for(:pages).nil?
  end

end
