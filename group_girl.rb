require 'nokogiri'
require 'open-uri'

class GroupGirl

  private

    def self.get_confessions(url)
      document  = Nokogiri::HTML(open(url))
      ids       = self.parse_id(document)
      texts     = self.parse_confession(document)
      group_hug = ids.zip(texts)
      self.confess(group_hug)
    end

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

    def self.confess(group_hug)
      group_hug.each { |confess| puts "#{confess[0]}: #{confess[1].capitalize}\n\n"; }
    end
end

GroupGirl.get_confessions("http://web.archive.org/web/20071025014638/http://grouphug.us/")