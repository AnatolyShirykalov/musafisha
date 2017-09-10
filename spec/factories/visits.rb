# == Schema Information
#
# Table name: visits
#
#  id         :integer          not null, primary key
#  aasm_state :string
#  user_id    :integer
#  concert_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  content    :text             default(""), not null
#

FactoryGirl.define do
  factory :visit do
    aasm_state "MyString"
    user nil
    concert nil
  end
end
