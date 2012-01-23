module ActsAsOwnedByUser
  extend ActiveSupport::Concern
 
  module ClassMethods
    def acts_as_owned_by_user
      instance_eval do
        belongs_to :user
        belongs_to :domain
        validates_presence_of :domain_id
        validates_presence_of :user_id
      end
    end
  end
end

ActiveRecord::Base.send :include, ActsAsOwnedByUser