module QuickJumpTargetsHelper
  def default_quickjump_targets
    if current_project
      quick_jumpify(current_project.pages)
    else
      default_quickjump_pages(8)
    end
  end

  def default_quickjump_projects(_limit = 20)
    targets = current_domain.projects.where(:active => true).limit(_limit).order("UPPER(title) ASC")
    quick_jumpify(targets)
  end

  def default_quickjump_pages(_limit = 20)
    targets = current_domain.pages.where("context_id IS NULL").limit(_limit).order("UPPER(title) ASC")
    quick_jumpify(targets)
  end

  def quick_jumpify(targets)
    targets.map do |record|
      url = url_for(record)
      record.attributes.merge(:type => record.class.to_s, :title => record.title, :url => url)
    end
  end

end
