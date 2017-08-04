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
#

class Visit < ApplicationRecord
  belongs_to :user
  belongs_to :concert
  include AASM

  scope :personal, lambda { |u| where(user: u) if u}

  aasm do
    state :unlooked, initial: true
    state :doubt
    state :ignored
    state :notgo
    state :go
    state :on
    state :done
    state :marked

    event :see do
      transitions from: :unlooked, to: :ignored
    end

    event :defer do
      transitions from: %i[ignored notgo go], to: :doubt
    end

    event :reject do
      transitions from: %i[ignored doubt go], to: :notgo
    end

    event :agree do
      transitions from: %i[ignored doubt notgo], to: :go
    end

    event :visit do
      transitions from: %i[ignored doubt notgo go unlooked], to: :on
    end

    event :finish do
      transitions from: %i[ignored doubt notgo go on], to: :done
    end

    event :mark do
      transitions from: :done, to: :marked
    end
  end


  def self.unlooked_for! user, concerts
    all = concerts.map(&:id)
    vs = Visit.where(concert_id: all, user: user, aasm_state: 'unlooked').to_a
    concerts.map do |c|
      vs.find{|v| v.concert_id == c.id} or Visit.create! user: user, concert_id: c.id
    end
  end
end
