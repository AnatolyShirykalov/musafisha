namespace :afisha do

  desc "TODO"
  task meloman: :environment do
    Meloman.new(region: 'Москва').list
  end

  desc "TODO"
  task sfcv: :environment do
    SfClassicVoice.new(region: 'San Francisco').list
  end

  desc "TODO"
  task cmsmoscow: :environment do
    Cmsmoscow.new(region: 'Москва').list
  end

  desc "TODO"
  task belcanto: :environment do
    Belcanto.new(region: 'Москва').list
  end

  desc "TODO"
  task san: :environment do
    SanFranciscoSymphony.new(region: 'San Francisco').list
  end

  desc "TODO"
  task musicatmenlo: :environment do
    Musicatmenlo.new(region: 'San Francisco').list
  end

  desc "TODO"
  task all: :environment do
    #Concert.where("date < ?", Date.today).select{|a| a.users.count == 0}.each do |c|
    #   c.destroy!
    #end
    Mosconsv.new(region: 'Москва').list
    Meloman.new(region: 'Москва').list
    Belcanto.new(region: 'Москва').list
    SfClassicVoice.new(region: 'San Francisco').list
    SanFranciscoSymphony.new(region: 'San Francisco').list
    Musicatmenlo.new(region: 'San Francisco').list
  end



  desc "TODO"
  task mosconsv: :environment do
    m = Mosconsv.new
    m.list
  end
  desc "TODO"
  task oldmosconsv: :environment do
    m = Mosconsv.new
    msg = ''
    last = Concert.where(site: "mosconsv").order("extid desc").first
    i0 = last ? last.extid : 16281
    redirects = 0

    (i0..150000).each do |i|
      i = 122312 if i==22264
      i = 123575 if i==122313
      if i%100 ==0
        print "\b"*(msg.size+1)
        msg = "#{i}\t#{redirects} redirects of #{i-i0}"
        print msg
      end
      begin
        m.concert("http://mosconsv.ru/ru/concert.aspx?id=#{i}")
      rescue =>e
        redirects += 1 if e.message == "redirect"
        next
      end
    end
  end

end
