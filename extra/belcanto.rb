class Belcanto < AeshRequest::AfishaParser
  private
  def base_url
    URI.parse('http://www.belcantofund.com/')
  end

  def _start_url
    "http://www.belcantofund.com/"
  end

  def collect_urls
    @doc.css(".event-teaser_name").map{|a| a.attr('href')}
  end

  def next_url
    nil
  end

  def image
    img = @doc.at_css('.one-event__pic').at_css('img')
    return nil if !img
    (base_url + img.attr('src')).to_s
  end

  def parse
    a = @doc.at_css('.one-event-options__option_place').at_css('.one-event-options__title').at_css('a')
    @hall_name = a.text
    @hall_url = a.attr('href')
    @search_params = {
      url: (base_url+@url).to_s,
      site: "belcanto"
    }
    @params = {
      description: no_script(@doc.at_css('.one-event__info')),
      date: Time.strptime((@doc.
              css('.one-event-options__value')[0..1]).
              map{|op| op.text}.join(":") + '+0300', "%d.%m.%Y:%H:%M %z")
    }
  end
end
