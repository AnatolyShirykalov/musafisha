class Meloman < AeshRequest::AfishaParser
  private
  def base_url
    URI.parse('http://meloman.ru')
  end

  def _start_url
    'http://www.meloman.ru/tickets/?page=1'
  end

  def parse
    sral = @doc.css('div[class="small-row align-left"]')
    tac = @doc.at_css('div[style="text-align: center;"]').css('p')

    raise "sral.size not in {1,2} in #{@url}" if sral.size != 2 and sral.size!=1
    raise "tac.size!=2 in #{@url}" if tac.size != 2
    txt = tac.first.text.gsub(/[\n ]+/,' ').gsub(", начало в ",':').split(' ')
    txt[1] = AeshRequest::get_month(txt[1])

    @hall_name = tac.last.text.gsub(/\n| {2,}/,'')
    @hall_url = @doc.css('a').find{|a| a.text=="схема проезда"}.attr('href')

    @search_params = {site: 'meloman', url: (base_url + @url).to_s }

    @last_date = Time.strptime(txt.join(':') + ' +0300', "%d:%m:%Y:%H:%M %z")
    @params = {
      description: no_script(sral.first).gsub(/[\n ]+/,' '),
      date: @last_date
    }
    @params[:program] =  no_script(sral.last).gsub(/[\n ]+/,' ') if sral.size == 2
    @params
  end

  def collect_urls
    @doc.css('div[class="today-tickets list"]').map do |ttl|
      ttl.at_css('div[class="whatandwho pseudo-link"]').
        attr('data-link')
    end
  end

  def next_url
    ar = @start_url.split('=')
    ar[-1] = ar[-1].to_i + 1
    ar.join('=')
  end

end
