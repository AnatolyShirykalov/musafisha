# == Schema Information
#
# Table name: pieces
#
#  id                :bigint           not null, primary key
#  classic_online_id :text
#  name              :text
#  composer_id       :bigint
#
# Indexes
#
#  pieces_classic_online_id_key  (classic_online_id) UNIQUE
#  uix_pieces_classic_online_id  (classic_online_id) UNIQUE
#
# Foreign Keys
#
#  pieces_composer_id_composers_id_foreign  (composer_id => composers.id) ON DELETE => restrict ON UPDATE => restrict
#
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
