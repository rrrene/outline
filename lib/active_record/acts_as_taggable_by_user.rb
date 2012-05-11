module ActsAsTaggableByUser
  extend ActiveSupport::Concern
 
  module ClassMethods
    def acts_as_taggable_by_user
      instance_eval do
        has_many :taggings, :as => :resource
        self.send :include, TagMethods
        attr_writer :tag_list
        after_save :write_tags
      end
    end
  end

  module TagMethods
    TAG_DELIMITER = ","

    def add_tags(string)
      array = string.is_a?(Array) ? string : string.split(TAG_DELIMITER)
      array.map(&:strip).each do |title|
        add_tag(title)
      end
    end

    def add_tag(title)
      tag = domain.tags.where("UPPER(title) = ?", title.upcase).first
      if tag.blank?
        tag = Tag.create(:domain_id => self.domain.id, :title => title)
      end
      domain.taggings.create(:tag_id => tag.id, :resource => self)
    end

    def tag_records
      tag_ids = Tagging.where(:resource_type => self.class.to_s, :resource_id => self.id).map(&:tag_id)
      Tag.where(:id => tag_ids).order("UPPER(tags.title)")
    end

    def tags
      tag_records.map(&:title)
    end

    def tags=(array_of_strings)
      Tagging.destroy_all(:resource_type => self.class.to_s, :resource_id => self.id)
      array_of_strings.each do |title|
        add_tag title
      end
    end

    def tag_list
      @tag_list ||= tags.join(TAG_DELIMITER)
    end

    def write_tags
      self.tags = tag_list.split(TAG_DELIMITER).map(&:strip).map(&:presence).compact
    end
  end
end

ActiveRecord::Base.send :include, ActsAsTaggableByUser