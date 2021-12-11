# == Schema Information
#
# Table name: composers
#
#  id                :bigint           not null, primary key
#  classic_online_id :text
#  name              :text
#  birth_year        :bigint
#  death_year        :bigint
#
# Indexes
#
#  composers_classic_online_id_key  (classic_online_id) UNIQUE
#  uix_composers_classic_online_id  (classic_online_id) UNIQUE
#
module Ohmymusic
  class Composer < Base
    self.table_name = self.name.demodulize.tableize
    has_many :pieces
    has_many :concert_tags
    searchkick word_start: [:name]
  end
end
