class DomainController < ApplicationController
  before_filter :set_body_template
  helper_method :resource, :resource_path

  def dashboard
    @body_template = :body_yield
  end

  def search
    @results = {}
    @filter_query = params[:query].presence
    search_classes.each do |model|
      if model.respond_to?(:search)
        arel = model.search(@filter_query)
        if arel.present?
          arel = arel.where(:domain_id => current_domain)
          @results[model.to_s] = arel.accessible_by(current_ability)
        end
      end
    end
  end

  def search_classes
    classes = Outline::Contexts.classes
    classes << Outline::ContextItems.classes
    classes << Outline::ContentItems.classes
    classes.flatten
  end

  def settings
    @page_header = t("#{controller_name}.#{action_name}.page_header")
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
