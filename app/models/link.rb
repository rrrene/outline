class Link < ActiveRecord::Base
  acts_as_content_item
  PROTOCOL_REGEXP = /^([^:]+\:\/\/)/

  def href
    base = self[:href]
    base = "http://#{base}" if base !~ PROTOCOL_REGEXP
    base
  end

  def href_without_protocol
    href.gsub(PROTOCOL_REGEXP, '')
  end

  validates_presence_of :href
end
