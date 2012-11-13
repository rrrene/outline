module ActsAsOwnedByUser
  extend ActiveSupport::Concern

  module ClassMethods
    def acts_as_owned_by_user
      instance_eval do
        has_activity
        belongs_to :user
        belongs_to :domain
        has_one :favorite, :as => :resource, :dependent => :destroy

        def self.search(query)
          q = "%" + query.gsub(' ', '%') + "%"
          if columns_hash['title']
            where("title LIKE ?", q)
          elsif columns_hash['text']
            where("text LIKE ?", q)
          else
            []
          end
        end

        validates_presence_of :domain_id
        validates_presence_of :user_id
      end
      of_this_kind = self.to_s.underscore.pluralize
      [::User, ::Domain].each do |model|
        model.instance_eval do
          has_many of_this_kind, :dependent => :destroy
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, ActsAsOwnedByUser