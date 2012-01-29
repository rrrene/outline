require 'test_helper'

class PageTest < ActiveSupport::TestCase
  setup do
    @page = Page.new
  end

  test "responds to user" do
    assert_not_nil @page
    assert @page.respond_to?(:context), "Project doesnot respond to :context"
    assert @page.respond_to?(:inner_content), "Project doesnot respond to :content"
  end

  test "Domain responds to pages" do
    assert Domain.first.respond_to?(:pages), "Domain doesnot respond to :pages"
  end

  test "saves and creates content" do
    @page.user = User.first
    @page.domain = Domain.first
    @page.title = "Test"
    assert @page.save
    assert_not_nil @page.inner_content
  end

  test "should add tags" do
    domain = Domain.first
    page = domain.pages.first
    tag_list = %w(one two three)
    
    page.add_tags tag_list.join(", ")

    assert_equal tag_list, page.tags
  end

  test "should move page to project" do
    domain = Domain.first
    page = domain.pages.last
    project = domain.projects.first
    assert_not_equal page.context, project.context

    page.move_to_project project

    assert_equal page.context, project.context
  end

  test "should move page to project via stringified id" do
    domain = Domain.first
    page = domain.pages.first
    project = domain.projects.last
    assert_not_equal page.context, project.context

    page.move_to_project project.id.to_s

    assert_equal page.context, project.context
  end

end
