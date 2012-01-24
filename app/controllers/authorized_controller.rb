class AuthorizedController < ApplicationController
  inherit_resources
  load_and_authorize_resource
  check_authorization

  def create(&block)
    create_user_owned_resource
    yield if block_given?
    create!
  end

  def index
    self.resource = resource_class.new
    index!
  end

  protected
  
    def begin_of_association_chain
      current_domain
    end

    def create_user_owned_resource
      self.resource = resource_class.new(params[resource_class.to_s.underscore])
      resource.user = current_user
      resource.domain = current_domain
    end

    def resource=(value)
      instance_variable_set("@#{resource_class.to_s.underscore}", value)
    end
end