class Loader < Thor
  ENV['RAILS_ENV'] ||= 'development'
  require File.expand_path('config/environment.rb')


  desc "start", "start all parsers"
  def start
    puts "Start load, #{timestamp}"
    invoke :belcanto
    invoke :cmsmoscow
    invoke :meloman
    invoke :mosconsv
    invoke :musicatmenlo
    invoke :san_francisco_symphony
    invoke :sf_classic_voice
    invoke :sfperformances
    puts "End load, #{timestamp}"
  end
  default_task :start

  desc "belcanto", "start belcanto parser"
  def belcanto
    puts "Start 'belcanto', #{timestamp}"
    Belcanto.new.list
    puts "End 'belcanto', #{timestamp}"
  end

  desc "cmsmoscow", "start cmsmoscow parser"
  def cmsmoscow
    puts "Start 'cmsmoscow', #{timestamp}"
    Cmsmoscow.new.list
    puts "End 'cmsmoscow', #{timestamp}"
  end

  desc "meloman", "start meloman parser"
  def meloman
    puts "Start 'meloman', #{timestamp}"
    Meloman.new.list
    puts "End 'meloman', #{timestamp}"
  end

  desc "mosconsv", "start mosconsv parser"
  def mosconsv
    puts "Start 'mosconsv', #{timestamp}"
    Mosconsv.new.list
    puts "End 'mosconsv', #{timestamp}"
  end

  desc "musicatmenlo", "start musicatmenlo parser"
  def musicatmenlo
    puts "Start 'musicatmenlo', #{timestamp}"
    Musicatmenlo.new.list
    puts "End 'musicatmenlo', #{timestamp}"
  end

  desc "san_francisco_symphony", "start san_francisco_symphony parser"
  def san_francisco_symphony
    puts "Start 'san_francisco_symphony', #{timestamp}"
    SanFranciscoSymphony.new.list
    puts "End 'san_francisco_symphony', #{timestamp}"
  end

  desc "sf_classic_voice", "start sf_classic_voice parser"
  def sf_classic_voice
    puts "Start 'sf_classic_voice', #{timestamp}"
    SfClassicVoice.new.list
    puts "End 'sf_classic_voice', #{timestamp}"
  end

  desc "sfperformances", "start sfperformances parser"
  def sfperformances
    puts "Start 'sfperformances', #{timestamp}"
    Sfperformances.new.list
    puts "End 'sfperformances', #{timestamp}"
  end

  no_tasks do
    def timestamp
      Time.zone.now.rfc822
    end
  end
end
