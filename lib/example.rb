module Outline::Setup
  class CreateResources
    def run
    end

    def page(attributes = {}, &block)
      page = Outline::Setup::Page.new(attributes)
      page.save
      page.instance_eval(&block)
    end

    def project(attributes = {}, &block)
      p = Outline::Setup::Project.new(attributes)
      p.instance_eval(&block)
      p.resource
    end
  end

  class Base
    attr_accessor :resource
    attr_accessor :resource_class

    def initialize(attributes = {})
      self.resource_class = eval("::#{self.class.to_s.split('::').last}")
      unless self.resource = find_existing_resource(attributes)
        self.resource = resource_class.new(attributes)
        resource.user = user
        resource.domain = user.domain
      end
    end

    def find_existing_resource(attributes)
      resource_class.where(attributes.merge(:domain_id => user.domain_id)).first
    end

    def method_missing(method_name, *args, &block)
      if resource.respond_to?("#{method_name}=")
        resource.send "#{method_name}=", *args
      else
        super
      end
    end

    def user
      User.first
    end

    def save
      resource.save
    end

    def save!
      resource.save!
    end
  end

  class Project < Base
    def page(attributes = {}, &block)
      save!
      page = Outline::Setup::Page.new(attributes)
      page.resource.context = self.resource.context
      page.save
      page.instance_eval(&block)
    end
  end

  class ResourceWithContent < Base
    def content_items(&block)
      save!
      puts resource.inspect + " << " + resource.inner_content.inspect
      items = Outline::Setup::ContentItems.new
      items.content_to_post_on = resource.inner_content
      items.instance_eval(&block)
      items
    end
  end

  class Page < ResourceWithContent
    def add_content_items(&block)
      super
      ids = resource.inner_content.content_items.map(&:id)
      resource.inner_content.content_item_ids = ids.reverse
    end
  end

  class TodoList < ResourceWithContent
  end

  class ContentItems
    attr_accessor :content_to_post_on # the Content object to which the items are saved

    def create_content_item(class_name, attributes)
      resource_class = eval("::#{class_name.to_s.classify}")
      item = resource_class.new(attributes)
      item.content_id = self.content_to_post_on.id
      item.user = self.content_to_post_on.holder.user
      item.domain = self.content_to_post_on.holder.user.domain
      item.save!
      item
    end

    def note(attributes)
      create_content_item :note, attributes
    end

    def divider(attributes)
      # create_content_item :divider, attributes
    end

    def link(attributes)
      create_content_item :link, attributes
    end

    def todo(attributes)
      create_content_item :todo, attributes
    end

    def todo_list(attributes, &block)
      #list = create_content_item(:todo_list, attributes)
      list = Outline::Setup::TodoList.new(attributes)
      list.resource.content_id = self.content_to_post_on.id
      list.save!
      list.instance_eval &block
    end

  end
end

class ExampleProjectAndPage < Outline::Setup::CreateResources
  def run
    project :title => "Example Project" do
      page :title => "Example Page" do
        tag_list "red, green, blue"
      
        content_items do
          note :text => "This is a note. Notes can help you keeping track of things."
          link :href => "outlineapp.com", :title => "Outline Homepage", :text => "This is a link. These are great to keep track of research or client websites."
          todo_list :title => "Todo List (1)" do
            content_items do
              todo :title => "Meet client"
              todo :title => "Do some research"
              todo :title => "Call accounting"
              todo :title => "Pickup milk"
            end
          end
        end
      end
    end
  end
end

