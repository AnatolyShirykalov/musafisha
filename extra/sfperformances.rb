class Sfperformances < AeshRequest::AfishaParser
  def base_url
    URI.parse("http://sfperformances.org/")
  end
 
  def _start_url
    (base_url + doc_at_utf(base_url).css('a').find{|a| a.text == "Buy Tickets"}.attr('href')).to_s
  end

  def next_url
    nil
  end

  def collect_urls
    from = (Time.now.month - 9) % 12
    urls = []
    @doc.css('.CollapsiblePanel')[from..-1].each do |cp|
      urls << cp.css('#newminilist').map{|nml| nml.at_css('a').attr('href')}
    end
    urls
  end

  def parse

  end
end
