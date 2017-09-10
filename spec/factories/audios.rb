# == Schema Information
#
# Table name: audios
#
#  id                 :integer          not null, primary key
#  audio_file_name    :string
#  audio_content_type :string
#  audio_file_size    :integer
#  audio_updated_at   :datetime
#  comment            :string
#  concert_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :audio do
    audio ""
    comment "MyString"
  end
end
