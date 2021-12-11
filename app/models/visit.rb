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


  def self.where_or_create! opts
    all = opts[:concerts].map(&:id)
    vs = Visit.where({concert_id: all}.merge(opts.except(:concerts)))
    opts[:concerts].map do |c|
      vs.find{|v| v.concert_id == c.id} or Visit.create! user: opts[:user], concert_id: c.id
    end
  end

  def self.unlooked_for! user, concerts
    self.where_or_create! concerts: concerts, user: user
  end

  def event_short_list
    aasm.events.select do |event|
      event.name.in? %i[defer reject agree]
    end
  end
end
