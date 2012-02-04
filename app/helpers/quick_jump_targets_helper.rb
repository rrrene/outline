module QuickJumpTargetsHelper
  def default_quickjump_targets
    Page.order("created_at desc").limit(8).map do |record|
      url = url_for(record)
      record.attributes.merge(:type => record.class.to_s, :title => record.title, :url => url)
    end
  end
end
