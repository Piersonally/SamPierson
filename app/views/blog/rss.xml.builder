xml.rss("version" => "2.0") do
  xml.channel do
    xml.title "Sam Pierson"
    xml.description "Sam Pierson's Blog: Recent Articles"
    xml.link root_url
    xml.language "en-us"
    xml.ttl "40"

    @articles.each do |article|
      xml.item do
        xml.title article.title
        xml.description markdown article.body
        xml.pubDate article.published_at.in_time_zone('US/Pacific').to_s(:rfc822)
        xml.link article_url article
        xml.guid article_url article
      end
    end
  end
end
