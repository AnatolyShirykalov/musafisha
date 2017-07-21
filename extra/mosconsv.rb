class Mosconsv < AeshRequest::AfishaParser
  private
  def base_url
    URI.parse('http://mosconsv.ru')
  end

  def _start_url
    "http://mosconsv.ru/ru/concert-date.aspx?sel_date=#{@date.to_s}"
  end

  def collect_urls
    @doc.css('a').map{|a| a.attr('href')}.select do |url|
      url.match /\/ru\/concert\.aspx\?id=\d+/
    end
  end

  def next_url
    @date+=1
    _start_url
  end

  def parse
    a =(@doc.at_css('div[class="afisha-hall dotted-link"]')>('span')>('a'))[0]
    @hall_name = a.inner_text
    @hall_url = (base_url + a.attr('href')).to_s
    @search_params = {
      site: 'mosconsv',
      url: (base_url + @url).to_s
    }
    @params = {
      program: no_script(@doc.at_css('div[class="afisha-part-body"]')),
      description: no_script(@doc.at_css('div[class="afisha-desc"]')),
      date: date
    }
  end

  def image
    @doc.css('script').select{|s| s.text.match /showPanel/}.each do |sP|
       return sP.text.match(/https?:\/\/.*\\\"/)[0][0..-3]
    end
    return nil
  end

  def date
    hhmm = @doc.
      at_css('div[id="time"]').
      at_css('span').
      children.map{|c| c.text}

    raise "Cannot find hhmm from #{@url}" if !hhmm

    ds = @doc.at_css('.afisha-date')
    txt = [
      ds.at_css('div#dom').inner_html,
      ds.at_css('div#mon').inner_html.mb_chars.downcase.to_s,
      ds.at_css('div#dow').inner_html,
    ]
    txt[2] = Time.new.year if txt[2].match(/\D/)
    txt[1] = AeshRequest::get_month(txt[1])

    raise "Cannot find txt from #{@url}" if !txt

    str = (txt + hhmm).join(':')+ ' +0300'
    puts str

    Time.strptime( str , "%e:%m:%Y:%H:%M %z")

  end

end
