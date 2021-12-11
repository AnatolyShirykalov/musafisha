# == Schema Information
#
# Table name: audios
#
#  id                 :bigint           not null, primary key
#  audio_file_name    :string
#  audio_content_type :string
#  audio_file_size    :bigint
#  audio_updated_at   :datetime
#  comment            :string
#  concert_id         :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_audios_on_concert_id  (concert_id)
#
# Foreign Keys
#
#  fk_rails_...  (concert_id => concerts.id)
#

require 'rails_helper'

RSpec.describe Audio, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
