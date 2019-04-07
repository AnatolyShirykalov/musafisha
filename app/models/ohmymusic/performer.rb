module Ohmymusic
  class Performer < Base
    self.table_name = self.name.demodulize.tableize
    searchkick
  end
end
