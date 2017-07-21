class SfClassicVoice < AeshRequest::AfishaParser
  def base_url
    URI.parse "https://www.sfcv.org"
  end

  def _start_url
    "https://www.sfcv.org/calendar"
  end

  def next_url
    gtnp = @start_doc.at_css('a[title="Go to next page"]')
    gtnp ? gtnp.attr('href') : nil
  end

  def collect_urls
    @start_doc = @doc
    @doc.css('a').select do |a|
      a.text == "Learn More"
    end.map do |a|
      a.attr('href')
    end
  end

  def parse

    @doc.at_css('ul.evt_details').css('li').select do |li|
      li.at_css('strong').text == "Venue:"
    end.each do |li|
      a = li.at_css('a')
      next if !a
      @hall_url = a.attr('href')
      @hall_name = a.text
    end
    @params = {
      description: desc,
      program: @doc.at_css('div.half.l').inner_html,
      date: date(@doc.at_css('span.date-display-single').text)
    }
    @search_params = {
      site: 'sf_classic_voice',
      url: (base_url + @url).to_s
    }
  end

  def desc
    container = (@doc.css('div.half').find do |dh|
      dh.at_css('span').text == "Performers" and
        dh.at_css('.program_slugs')
    end or @doc.at_css('div.field-items') )
    container ? container.inner_html : nil
  end

  def date(s)
    DateTime.strptime(
      s.gsub(/[\r\n,]/,'') + " Pacific Standard Time",
      '%a %B %e %Y %I:%M%P %Z'
    )
  end

  def image
    iab = @doc.at_css('div.image-attach-body')
    return iab if iab.nil?
    img = iab.at_css('img')
    img ? img.attr('src') : nil
  end
end
