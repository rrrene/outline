class User < ActiveRecord::Base
  acts_as_authentic
  has_activity

  def name
    "#{first_name} #{last_name}".presence || login
  end
  
  belongs_to :domain
end
