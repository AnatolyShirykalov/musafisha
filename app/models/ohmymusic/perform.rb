# == Schema Information
#
# Table name: performs
#
#  id                :bigint           not null, primary key
#  classic_online_id :text
#  date              :datetime
#  user_id           :bigint
#  likes             :bigint
#  piece_id          :bigint
#  group_id          :bigint
#  has_audio         :boolean
#  content_length    :bigint
#  dl_status         :text
#
# Indexes
#
#  performs_classic_online_id_key  (classic_online_id) UNIQUE
#  uix_performs_classic_online_id  (classic_online_id) UNIQUE
#
# Foreign Keys
#
#  performs_group_id_groups_id_foreign  (group_id => groups.id) ON DELETE => restrict ON UPDATE => restrict
#  performs_piece_id_pieces_id_foreign  (piece_id => pieces.id) ON DELETE => restrict ON UPDATE => restrict
#  performs_user_id_users_id_foreign    (user_id => users.id) ON DELETE => restrict ON UPDATE => restrict
#
module Ohmymusic
  class Perform < Ohmymusic::Base
    self.table_name = self.name.demodulize.tableize

    belongs_to :piece
    has_one :composer, through: :piece
    belongs_to :group
    has_many :performers, through: :group

    searchkick

    def search_data
      attributes.symbolize_keys.merge({
        piece: piece.name,
        composer: composer.name,
        performers: performers.map(&:name),
        joined_performers: performers.map(&:name).join(' '),
        comments_count: 0,
        summary: performers.map(&:name) + [composer.name, piece.name],
      })
    end
  end
end
