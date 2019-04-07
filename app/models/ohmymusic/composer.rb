module Ohmymusic
  class Composer < Base
    self.table_name = self.name.demodulize.tableize
    has_many :pieces
    has_many :concert_tags
    searchkick
  end
end
