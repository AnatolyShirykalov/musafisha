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

require 'rails_helper'

RSpec.describe Visit, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
