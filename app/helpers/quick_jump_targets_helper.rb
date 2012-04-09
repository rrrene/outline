module QuickJumpTargetsHelper
  def default_quickjump_targets
    targets = find_last_active_contents(:limit => 8, :type => Page).map(&:holder).compact.uniq
    targets.map do |record|
      url = url_for(record)
      record.attributes.merge(:type => record.class.to_s, :title => record.title, :url => url)
    end
  end

  # TODO: this solution seems terrible
  def find_last_active_contents(options = {})
    limit = options.fetch(:limit, 8)
    types = [options.fetch(:type)].flatten.compact.map(&:to_s)
    chain = Activity.accessible_by(current_ability).where(:user_id => current_user.id)
    chain = chain.where("verb <> 'read'").order("created_at DESC")
    offset = 0
    contents = []
    while contents.length < limit do
      activity = chain.offset(offset).first
      content = activity.content.presence
      if content.present? && !contents.include?(content)
        if !types.present? || types.include?(content.holder_type)
          contents << activity.content
        end
      end
      offset += 1
    end
    contents
  end
end
