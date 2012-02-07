require 'open-uri'

class Link < ActiveRecord::Base
  acts_as_content_item
  PROTOCOL_REGEXP = /^([^:]+\:\/\/)/


  before_save :fetch_href

  def href
    base = self[:href]
    base = "http://#{base}" if base !~ PROTOCOL_REGEXP
    base
  end

  def href_without_protocol
    href.gsub(PROTOCOL_REGEXP, '')
  end

  def fetch_href
    fetch_href_meta_info if new_record?
  rescue
    nil
  end

  def fetch_href_meta_info
    response = open(href).read
    if title = response.scan(/<title>([^<]+)<\/title>/).flatten.first
      self.title = title
    end
  end

  validates_presence_of :href
end
