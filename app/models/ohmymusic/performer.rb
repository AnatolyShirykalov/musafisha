# == Schema Information
#
# Table name: performers
#
#  id                :bigint           not null, primary key
#  classic_online_id :text
#  instrument        :text
#  url               :text
#  name              :text
#
# Indexes
#
#  performers_classic_online_id_key  (classic_online_id) UNIQUE
#  uix_performers_classic_online_id  (classic_online_id) UNIQUE
#
module Ohmymusic
  class Performer < Base
    self.table_name = self.name.demodulize.tableize
    searchkick word_start: [:name]
  end
end
