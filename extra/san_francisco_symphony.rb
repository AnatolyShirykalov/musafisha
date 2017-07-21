class SanFranciscoSymphony < AeshRequest::AfishaParser
  private
  def base_url
    URI.parse 'https://www.sfsymphony.org'
  end

  def _start_url
    "https://www.sfsymphony.org/Buy-Tickets/Calendar"
  end

  def collect_urls
    @start_doc = @doc
    @doc.css('li.calendar-events-item').select do |li|
      li.at_css('h6.calendar-events-message').text != "This event has passed"
    end.map do |li|
      u = li.at_css('h3.calendar-events-title').at_css('a').attr('href')
      puts u
      u
    end
  end

  def next_url
    @start_doc.at_css('a.month-lnk.lnk-next.calendar-minical-next.calendar-minical-toggle').attr('href')
  end

  def parse
    begin
    @doc.at_css('div#buy-tickets').css('li').each do |li|
      acc =  @doc.at_css('div.artist-credit-container')
      wcc = @doc.at_css('div.work-credit-container')

      ali = li.at_css('p.event-details-actions')
      next if !ali
      a = ali.at_css('a')

      @hall_name = a.inner_text
      @hall_url = a.attr('href')

      @params = {
        description: acc ? acc.inner_html : nil,
        program: wcc ? wcc.inner_html : nil,
        date: date(li.at_css('h5').text)
      }
      @search_params = {
        site: 'san_francisco_symphony',
        url: (base_url + @url).to_s,
      }

      save!
    end
    rescue => e
      raise "parse failed on url #{@url}\n#{e.message}"
    end
  end

  def date(s)
    DateTime.strptime(s.gsub(/[\r\n ]{2,}|,|at /,'') + " Pacific Standard Time", '%a %b %e %Y %l:%M%P %Z')
  end
end
