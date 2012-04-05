class SetupController < ApplicationController
  layout Proc.new { |c| c.themed_layout(:login) }

  def create_first_user
    ensure_domain!
    @user = User.new(params[:user] || default_params)
    @user.domain = @domain
    if request.post? && @user.valid?
      @user.save
      set_activity_user(@user)
      Activity.create(:domain => @domain, :resource => @domain, :user => @user, :verb => "create")
      if params[:create_example] == "true"
        Outline::CreateExampleResources.new.run
      end
      redirect_to root_url
    end
  end

  private

  def default_params
    if Rails.env.development?
      {:login => "admin", :password => "admin", :password_confirmation => "admin", :email => "example@example.org"}
    else
      {}
    end
  end

  def ensure_domain!
    @domain = if Domain.count == 0
      Domain.create(:title => "Outline") 
    else
      Domain.first
    end
  end
end
