module ContentItemResources::TestCase
  module InstanceMethods
    private

    def collection_key
      resource_key.pluralize
    end

    def resource_class
      resource_class_name.constantize
    end

    def resource_class_name
      self.class.to_s.gsub(/(Test|ControllerTest)$/, '').singularize
    end

    def resource_key
      resource_class_name.underscore
    end

    def resource_attributes
      raise "Implement me!"
    end

    def alter_attributes(attributes)
      clone = attributes.dup
      clone.each do |key, value|
        clone[key] = "#{value} (changed)" if %w(name text title).include?(key.to_s)
      end
      clone
    end
  end

  module Base
    extend ActiveSupport::Concern

    included do
      self.send :include, InstanceMethods
      
      test "should create item on page" do
        with_login do |user|
          page = user.domain.pages.first
          assert_not_nil page
          assert_not_nil page.content, "Page should have content"
          
          assert_created(resource_class) do
            attributes = resource_attributes.merge(:content_id => page.content.id)
            post :create, resource_key => attributes
            assert_response :redirect
          end
        end
      end

      test "should destroy page" do
        with_login do |user|
          assert_destroyed(resource_class) do
            delete :destroy, :id => 1
            assert_response :redirect
          end
        end
      end

      test "should GET new" do
        with_login do |user|
          get :new
          assert_response :success
        end
      end

      test "should GET edit" do
        with_login do |user|
          get :edit, :id => 1
          assert_response :success
        end
      end

      test "should update item" do
        with_login do |user|
          resource = resource_class.first
          assert_not_nil resource
          assert_not_nil resource.content_item
          attributes = alter_attributes(resource_attributes)
          put :update, :id => resource, resource_key => attributes
          assert_not_nil assigns[resource_key]
          attributes.each do |attribute, value|
            assert_equal value, assigns[resource_key].attributes[attribute.to_s]
          end
          assert_response :redirect
        end
      end

      test "should GET show" do
        with_login do |user|
          get :show, :id => 1
          assert_response :success
        end
      end

    end
  end

  module Config
    extend ActiveSupport::Concern

    module ClassMethods
      def should_act_as_content_item_resources
        self.send :include, Base
      end
    end
  end
end

ActionController::TestCase.send :include, ContentItemResources::TestCase::Config
