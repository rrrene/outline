class AuthorizedController < ApplicationController
  inherit_resources
  load_and_authorize_resource
  check_authorization

  def create
    self.resource = resource_class.new(params[resource_class.to_s.underscore])
    resource.user = current_user
    resource.domain = current_domain
    create!
  end

  protected
  
    def begin_of_association_chain
      current_domain
    end

    def resource=(value)
      instance_variable_set("@#{resource_class.to_s.underscore}", value)
    end
end