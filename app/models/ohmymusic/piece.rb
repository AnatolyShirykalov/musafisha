module Ohmymusic
  class Piece < Base
    self.table_name = self.name.demodulize.tableize
    belongs_to :composer
    searchkick
    scope :search_import, -> { includes(:composer) }

    def search_data
      {
        name_with_composer: "#{composer.name} #{name}"
      }
    end


    def as_json(options={})
      {
        id: id,
        name: "#{composer.name} #{name}",
      }
    end
  end
end
