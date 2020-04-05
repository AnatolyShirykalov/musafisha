module Ohmymusic
  class Piece < Base
    self.table_name = self.name.demodulize.tableize
    belongs_to :composer
    searchkick word_start: [:name_with_composer]
    scope :search_import, -> { includes(:composer) }

    def search_data
      {
        name_with_composer: name_with_composer,
        composer_id: composer_id,
      }
    end


    def as_json(options={})
      {
        id: id,
        name: name_with_composer,
      }
    end

    def name_with_composer
      "#{composer.name} #{name}"
    end
  end
end
