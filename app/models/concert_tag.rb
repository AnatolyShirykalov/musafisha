# == Schema Information
#
# Table name: concert_tags
#
#  id           :bigint           not null, primary key
#  concert_id   :bigint
#  composer_id  :bigint
#  piece_id     :bigint
#  performer_id :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_concert_tags_on_composer_id   (composer_id)
#  index_concert_tags_on_concert_id    (concert_id)
#  index_concert_tags_on_performer_id  (performer_id)
#  index_concert_tags_on_piece_id      (piece_id)
#
# Foreign Keys
#
#  fk_rails_...  (concert_id => concerts.id)
#
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
