# == Schema Information
#
# Table name: halls
#
#  id                :bigint           not null, primary key
#  name              :string
#  url               :string
#  icon_file_name    :string
#  icon_content_type :string
#  icon_file_size    :bigint
#  icon_updated_at   :datetime
#  city_id           :bigint
#  address           :text
#  map_address       :text
#  map_hint          :text
#  latitude          :float
#  longitude         :float
#  lat               :float
#  lon               :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_halls_on_city_id  (city_id)
#

FactoryGirl.define do
  factory :hall do
    name "MyString"
    url "MyString"
    icon ""
  end
end
