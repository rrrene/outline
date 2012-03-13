class UsersController < ApplicationController
  authorized_resources
  before_filter :set_page_header, :only => [:show]

  def show
    show! {
      @activities = @user.activities.where("verb <> ?", "read").limit(30)
    }
  end

  def set_page_header
    @page_header = resource.try(:name)
    @page_hint = t("#{controller_name}.#{action_name}.page_hint")
  end

end
