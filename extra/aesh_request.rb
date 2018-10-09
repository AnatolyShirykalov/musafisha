module AeshRequest
  def AeshRequest::get_bin(url, http_client)
    res = http_client.get(url, {}, {
      'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
      'Accept-Encoding' => 'gzip,deflate,sdch',
      'Accept-Language' => 'en-US,en;q=0.8',
      'User-Agent' => "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.75 Safari/537.36"
    })
    if res.status/100 == 3
      return AeshRequest::get_bin(res.headers['Location'], http_client)
    end
    if res.status != 200
      puts(url)
      puts("status: #{res.status}")
      binding.pry if Rails.env == 'development' and res.status!=500
      return nil if res.status == 500
      return AeshRequest::get_bin(url, http_client)
    end
    res.body
  end

  def AeshRequest::get_month(text)
    kvs = { "января"   => "01", "февраля" => "02", "марта"  => "03", "апреля"  => "04",
	    "мая"      => "05", "июня"    => "06", "июля"   => "07", "августа" => "08",
	    "сентября" => "09", "октября" => "10", "ноября" => "11", "декабря" => "12"}
    kvs[text]
  end

  def AeshRequest::doc_at_utf(url, http_client)
    begin
      html = AeshRequest::get_bin(url, http_client)
      return nil if html.nil?
      doc = Nokogiri::HTML(html.gsub('charset=windows-1251"', 'charset=utf-8"'))
    rescue => e
      case e
      when OpenURI::HTTPError
        puts 'OpenURI::HTTPError'
	nil
      else
	raise e
      end
    end
  end

  class AfishaParser
    MONTHS = {
      "января"   => '01',
      "февраля"  => '02',
      "марта"    => "03",
      "апреля"   => "04",
      "мая"      => "05",
      "июня"     => "06",
      "июля"     => "07",
      "августа"  => "08",
      "сентября" => "09",
      "октября"  => "10",
      "ноября"   => "11",
      "декабря"  => "12"
    }
    DAYNAMES = {
      "воскресенье" => "Sunday",
      "понедельник" => "Monday",
      "вторник"     => "Tuesday",
      "среда"       => "Wednesday",
      "четверг"     => "Thursday",
      "пятница"     => "Friday",
      "суббота"     => "Saturday"
    }

    def initialize(params = {})
      @direct = params.has_key?(:direct) ? params[:direct] : true
      @region_name = params[:region] || 'Москва'
      @region = City.find_or_create_by!(name: @region_name)
      @http = HTTPClient.new()
      @http.transparent_gzip_decompression = true
      @doc = nil
      @date = params[:date] || Date.today
      @start_url = _start_url
    end

    def list(start_url=@start_url)
      @count = 0
      return nil if !start_url # finish
      @start_url = start_url
      @doc = doc_at_utf(@start_url)
      #binding.pry
      collect_urls.each do |url|
        @count += 1 if concert(url)
        @skip = false
      end
      list(next_url) if @count >0
    end

    def concert(url)
      begin
        @url = URI.encode(url)
        @doc = doc_at_utf(@url)

        return nil if !@doc
        parse

        return nil if @skip

        return save! if @direct
      rescue => e
        binding.pry if Rails.env == 'development'
        raise e
      end
    end

    private

    def save!
      raise "No hall name in #{@url}" if !@hall_name
      @hall_name = @hall_name.mb_chars.upcase.to_s
      @hall = @region.halls.find_or_create_by(name: @hall_name)
      raise "Cannot find or create hall #{@hall_name}" if !@hall
      if !@hall.url
        @hall.url = (base_url + @hall_url).to_s if @hall_url
        @hall.save!
      end

      @concert = @hall.concerts.find_or_initialize_by(@search_params)
      @concert.assign_attributes @params
      im = image
      #@concert.imageR = im if im
      @concert.image = open((base_url+im).to_s) if im
      @concert.save!

    end

    def no_script(doc_part)
      dp = doc_part.clone
      dp.css('script').each{|s| s.remove}
      dp.inner_html
    end
    def _start_url
      nil
    end
    def next_url
    end
    def extit
    end
    def base_url
    end
    def parse
      raise "Undefined parse in AeshRequest::AfishaParser"
    end
    def doc_at_utf(url)
      AeshRequest::doc_at_utf((base_url + url).to_s, @http)
    end
    def image
      nil
    end

    def normalize_string(str, replace_many_whitespace: true, strip: true, downcase: true, uppercase: false)
      s = str
      s = s&.gsub(/\s+/, ' ') if replace_many_whitespace
      s = s&.strip if strip
      s = s&.downcase if downcase
      s = s&.uppercase if uppercase
      s || ""
    end

    def normalize_month(datestr)
      s = datestr
      MONTHS.each do |key, val|
        s = s&.gsub(/#{key}/i, val)
      end
      s
    end

    def normalize_weekday(datestr)
      s = datestr
      DAYNAMES.each do |key, val|
        s = s&.gsub(/#{key}/i, val)
      end
      s
    end
  end
# https://ruby-doc.org/stdlib-2.3.0/libdoc/time/rdoc/Time.html#method-c-strptime
end
