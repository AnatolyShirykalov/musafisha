class Cmsmoscow < AeshRequest::AfishaParser
  private
  def base_url
    URI.parse('http://cmsmoscow.ru/')
  end

  def _start_url
    "http://cmsmoscow.ru/events/"
  end

  def collect_urls
    @start_doc = @doc
    @doc.css('.wpmudevevents-calendar-event').
      map{|a| a.attr('href')}
  end

  def next_url
    @start_doc.at_css('.event-pagination').
      css('a').last.attr('href')
  end

  def image
    img = @doc.at_css('.wpmudevevents-header').at_css('img')
    return nil if !img
    (base_url + img.attr('src')).to_s
  end

  def parse
    @skip = false
    hg = @doc.at_css(".hall.grow")

    if !hg or !hg.child
      @skip = true
      return nil
    end

    @hall_name = hg.text
    @hall_url = hg.at_css('a').attr('href')

    @search_params = {
      url: (base_url+@url).to_s,
      site: 'cmsmoscow'
    }

    @params = {
      description: @doc.at_css('#wpmudevents-single').
        at_css('h2').text,
      program: no_script(@doc.at_css('#wpmudevevents-contentbody')),
      date: Time.parse(@doc.at_css('.wpmudevevents-date').
                       at_css('span[itemprop="startDate"]').
                       attr('datetime'))
    }
  end
end
