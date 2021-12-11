# == Schema Information
#
# Table name: visits
#
#  id         :bigint           not null, primary key
#  aasm_state :string
#  user_id    :bigint
#  concert_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  content    :text             default(""), not null
#
# Indexes
#
#  index_visits_on_concert_id              (concert_id)
#  index_visits_on_user_id                 (user_id)
#  index_visits_on_user_id_and_concert_id  (user_id,concert_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (concert_id => concerts.id)
#  fk_rails_...  (user_id => users.id)
#

FactoryGirl.define do
  factory :visit do
    aasm_state "MyString"
    user nil
    concert nil
  end
end
