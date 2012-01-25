module ActsAsTaggableByUser
  extend ActiveSupport::Concern
 
  module ClassMethods
    def acts_as_taggable_by_user
      instance_eval do
        acts_as_taggable
      end
    end
  end

  def add_tags(list)
    self.tag_list = list
    self.save!
  end
end

ActiveRecord::Base.send :include, ActsAsTaggableByUser