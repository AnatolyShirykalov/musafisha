class Sfperformances < AeshRequest::AfishaParser
  def base_url
    URI.parse("http://sfperformances.org/")
  end

  def _start_url
    url = doc_at_utf(base_url).at_css('#browse-performances a:contains("By Date")').attr('href')
    (base_url + url).to_s
  end

  def next_url
    nil
  end

  def collect_urls
    # from = (Time.now.month - 9) % 12
    # urls = []
    # @doc.css('.CollapsiblePanel')[from..-1].each do |cp|
    #   urls << cp.css('#newminilist').map{|nml| nml.at_css('a').attr('href')}
    # end
    # urls
    @doc.css('.panel-content-performances .performances-listing-details-outer a.panel-content-link')
      &.map { |anode| anode.attr("href") }
  end

  def parse
    a = @doc.at_css(".perfinfo-venue a")
    @hall_name = a.previous.inner_text
    @hall_url = a.attr("href")

    @search_params = {
      site: 'sfperformances',
      url: (base_url + @url).to_s
    }

    desc = parse_desc
    date = parse_date
    program = parse_program
    @params = {
      site: "sfperformances",
      url: (base_url + @url).to_s,
      description: desc,
      program: program,
      date: date
    }
  end

  def image
    img = @doc.at_css(".perfhead .perfphoto img")
    return img.attr("src") if img
    nil
  end

  def parse_desc
    desc = @doc.at_css('.perfinfo')
    no_script(desc)
  rescue
    nil
  end

  def parse_date
    date = normalize_string(@doc.at_css('.perfinfo-date')&.children&.first&.text)
    date = Time.strptime(date, "%A, %B %d, %Y")  if date
    date
  rescue
    nil
  end

  def parse_program
    p = @doc.at_css('.perfdetails .perfprogram')
    no_script(p)
  rescue
    nil
  end
end
