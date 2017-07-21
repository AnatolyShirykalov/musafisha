class Musicatmenlo < AeshRequest::AfishaParser
  def base_url
    URI.parse "http://www.musicatmenlo.org/"
  end

  def _start_url
    "http://www.musicatmenlo.org/calendar/"
  end

  def next_url
    nil
  end

  def collect_urls
    @doc.css('a[title="more info"]').map{|a| a.attr('href')}
  end
  def parse
    @params = {
      site: "musicatmenlo",
      url: (base_url + @url).to_s
    }

    @search_params = {
      date: date
    }

    @doc.at_css('div.venue').css('a').each do |a|
      @hall_url = a.attr('href')
      @hall_name = a.text
    end

    @doc.css('div.widget-content-item').each do |wci|
      case wci.at_css('h3').text
      when /Artists?/
        @params[:description] = wci.inner_html
      when 'PROGRAM'
        @params[:program] = wci.inner_html
      else
        raise "strange wci.h3.text #{wci.at_css('h3').text}"
      end
    end

  end

  def date
    begin
    s = [
      @doc.at_css('.calendar-events-label').text,
      @doc.at_css('span.time').text,
      "Pacific Standard Time"
    ].join(' ').gsub(/[\r\n ]{2,}/,' ').strip
    d = DateTime.strptime(s, '%A %e%b %I:%M %P %Z')
    d0 = DateTime.strptime("31 08", "%d %m")
    return (d > d0 ? d : d + 1.year)
    rescue => e
      binding.pry
    end
  end
end
