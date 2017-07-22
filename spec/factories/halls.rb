# == Schema Information
#
# Table name: halls
#
#  id                :integer          not null, primary key
#  name              :string
#  url               :string
#  icon_file_name    :string
#  icon_content_type :string
#  icon_file_size    :integer
#  icon_updated_at   :datetime
#  city_id           :integer
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

FactoryGirl.define do
  factory :hall do
    name "MyString"
    url "MyString"
    icon ""
  end
end
