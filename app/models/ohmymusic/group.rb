# == Schema Information
#
# Table name: groups
#
#  id                :bigint           not null, primary key
#  classic_online_id :text
#
# Indexes
#
#  groups_classic_online_id_key  (classic_online_id) UNIQUE
#  uix_groups_classic_online_id  (classic_online_id) UNIQUE
#
module Ohmymusic
  class Group < Base
    has_and_belongs_to_many :performers, join_table: :group_performers
  end
end
