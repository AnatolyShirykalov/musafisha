module Ohmymusic
  class Piece < Base
    self.table_name = self.name.demodulize.tableize
    belongs_to :composer
    searchkick
  end
end
