module ActsAsTaggableByUser
  extend ActiveSupport::Concern
 
  module ClassMethods
    def acts_as_taggable_by_user
      instance_eval do
        acts_as_taggable
        self.send :include, TagMethods
        alias_method_chain :tags, :domain
        alias_method_chain :tag_list, :domain
        alias_method_chain :tag_list=, :domain
      end
    end
  end

  module TagMethods
    def add_tags(list)
      if self.domain
        self.activity_action = "tag" if self.respond_to?(:activity_action)
        self.domain.tag(self, :with => list, :on => :tags)
      end
    end

    def tags_with_domain
      self.domain.blank? ? [] : self.tags_from(self.domain)
    end

    def tag_list_with_domain
      tags.join(', ')
    end

    def tag_list_with_domain=(value)
      add_tags value
    end
  end
end

ActiveRecord::Base.send :include, ActsAsTaggableByUser