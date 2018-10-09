class Musicatmenlo < AeshRequest::AfishaParser
  def base_url
    URI.parse "http://www.musicatmenlo.org/"
  end

  def _start_url
    "http://www.musicatmenlo.org/"
  end

  def next_url
    nil
  end

  def collect_urls
    @doc.css('div.widget-content-item a[title="read more"]').map{|a| a.attr('href')}
  end
  def parse
    @params = {
      site: "musicatmenlo",
      url: (base_url + @url).to_s
    }

    @search_params = @params.clone

    @doc.at_css('div.venue').css('a').each do |a|
      @hall_url = a.attr('href')
      @hall_name = a.text
    end

    @params[:description] = parse_description
    @params[:date] = parse_date

    # @doc.css('div.widget-content-item').each do |wci|
    #   case wci.at_css('h3').text
    #   when /Artists?/
    #     @params[:description] = wci.inner_html
    #   when 'PROGRAM'
    #     @params[:program] = wci.inner_html
    #   else
    #     raise "strange wci.h3.text #{wci.at_css('h3').text}"
    #   end
    # end

  end

  def parse_description
    desc = @doc.at_css('.event-detail-about')
    no_script(desc)
  end

  def image
    img = @doc.at_css('.event-detail-img img')
    return img.attr('src') if img.present?
    nil
  rescue
    nil
  end

  def parse_date
    d = normalize_string(
      @doc.at_css('.calendar-events-label').inner_text,
      downcase: false
    )
    d = Time.strptime(d , "%A %d%b") if d
  rescue
    nil
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
