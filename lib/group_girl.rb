require 'nokogiri'
require 'open-uri'
require_relative '../app/models/group_hug'

class GroupGirl
  def self.get_confessions
    document  = Nokogiri::HTML(open("http://web.archive.org/web/20071025014638/http://grouphug.us/"))
    ids       = self.parse_id(document)
    texts     = self.parse_confession(document)
    group_hug = ids.zip(texts)
    self.confess(group_hug)
    self.import(group_hug)
  end

private

  def self.parse_id(id, confession_ids = [])
    id.css(".conf-id").each do |confession|
      confession_ids << confession.at_css("a").text.strip
    end
    confession_ids
  end

  def self.parse_confession(confession, confession_texts = [])
    confession.css(".conf-text").each do |confession|
      confession_texts << confession.at_css("p").text.strip
    end
    confession_texts
  end

  def self.import(group_hug)
    GroupHug.transaction do
      group_hug.each do |confession|
        GroupHug.create!(:confession_id => confession[0], :confession_text => confession[1])
      end
    end
  end

  def self.confess(group_hug)
    group_hug.each { |confess| puts "#{confess[0]}: #{confess[1].capitalize}\n\n"; }
  end
end
