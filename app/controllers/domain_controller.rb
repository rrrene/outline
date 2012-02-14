class DomainController < ApplicationController
  before_filter :set_body_template
  helper_method :resource, :resource_path

  def settings
    Page
    @domain = current_domain
    if request.put?
      @domain.update_attributes(params[:domain])
      @success = @domain.save
    end
  end

  def resource
    @domain
  end

  def resource_path(domain)
    "/"
  end

  def set_body_template
    @body_template = :body_resource
  end
end
