# == Schema Information
#
# Table name: concerts
#
#  id                 :bigint           not null, primary key
#  date               :datetime
#  row                :string
#  url                :string
#  site               :string
#  alltext            :string
#  hall_id            :bigint
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :bigint
#  image_updated_at   :datetime
#  program            :string
#  description        :string
#  tsv_body           :tsvector
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_concerts_on_hall_id   (hall_id)
#  index_concerts_on_tsv_body  (tsv_body) USING gin
#
# Foreign Keys
#
#  fk_rails_...  (hall_id => halls.id)
#

require 'rails_helper'

RSpec.describe Concert, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
