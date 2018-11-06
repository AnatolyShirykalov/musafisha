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

  [
    ["belcanto", "start belcanto parser", Belcanto],
    ["cmsmoscow", "start cmsmoscow parser", Cmsmoscow],
    ["meloman", "start meloman parser", Meloman],
    ["mosconsv", "start mosconsv parser", Mosconsv],
    ["musicatmenlo", "start musicatmenlo parser", Musicatmenlo],
    ["san_francisco_symphony", "start san_francisco_symphony parser", SanFranciscoSymphony],
    ["sf_classic_voice", "start sf_classic_voice parser", SfClassicVoice],
    ["sfperformances", "start sfperformances parser", Sfperformances]

  ].each do |name, desc, klass|
    desc name, desc
    define_method name.to_sym do
      puts "Start '#{name}', #{timestamp}"
      klass.new.list
      puts "End '#{name}', #{timestamp}"
    end
  end

  no_tasks do
    def timestamp
      Time.zone.now.rfc822
    end
  end
end
