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
FactoryGirl.define do
  factory :concert_tag do
    concert nil
    composer_id ""
    piece_id ""
    performer_id ""
  end
end
