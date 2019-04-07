class ConcertTag < ApplicationRecord
  belongs_to :concert
  belongs_to :composer, class_name: 'Ohmymusic::Composer'
  belongs_to :piece, class_name: 'Ohmymusic::Piece'
  belongs_to :performer, class_name: 'Ohmymusic::Performer'
  validate :exactly_one_key

  def exactly_one_key
    persisted_ids = [composer, piece, performer].compact.map(&:id)
    ids = [composer_id, piece_id, performer_id].compact
    if persisted_ids.size != 1 || ids.size != 1
      self.errors.add(:base, "Неправильная связка с ohmymusic")
    end
  end
end
