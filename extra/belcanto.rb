class Belcanto < AeshRequest::AfishaParser
  private
  def base_url
    URI.parse('http://www.belcantofund.com/')
  end

  def _start_url
    "http://www.belcantofund.com/"
  end

  def collect_urls
    @doc.css(".event .event-prospect .event-name").map{|a| a.attr('href')}
  end

  def next_url
    nil
  end

  def image
    img = @doc.at_css('.one-event-header').at_css('img')
    return nil if !img
    (base_url + img.attr('src')).to_s
  end

  def parse
    a = @doc.at_css('.one-event-hall_body').at_css('.one-event-hall-info').at_css('a.one-event-hall-info-name')
    @hall_name = a.text.try(:strip)
    @hall_url = a.attr('href')
    @search_params = {
      url: (base_url+@url).to_s,
      site: "belcanto"
    }
    @params = {
      description: no_script(@doc.at_css('.one-event-info_body')),
      # date: Time.strptime((@doc.
      #         css('.one-event-options__value')[0..1]).
      #         map{|op| op.text}.join(":") + '+0300', "%d.%m.%Y:%H:%M %z")
      date: Time.strptime((@doc.
                at_css('.one-event-date .event-day')
                .attr('content') + ' +0300'),
            "%Y-%m-%dT%H:%M %z")
    }
  end
end
