# == Schema Information
#
# Table name: concerts
#
#  id                 :integer          not null, primary key
#  date               :datetime
#  row                :string
#  url                :string
#  site               :string
#  alltext            :string
#  hall_id            :integer
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  program            :string
#  description        :string
#  tsv_body           :tsvector
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Concert, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
