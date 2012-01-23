class AuthorizedController < ApplicationController
  inherit_resources
  load_and_authorize_resource
  check_authorization

  protected
  
    def begin_of_association_chain
      current_domain
    end
end