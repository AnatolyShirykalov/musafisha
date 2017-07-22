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

FactoryGirl.define do
  factory :concert do
    date "2017-07-21 20:30:38"
    row "MyString"
    url "MyString"
    site "MyString"
    city nil
    image ""
    program "MyString"
    desctiption "MyString"
  end
end
