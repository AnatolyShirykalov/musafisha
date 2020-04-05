module Ohmymusic
  class Performer < Base
    self.table_name = self.name.demodulize.tableize
    searchkick word_start: [:name]
  end
end
