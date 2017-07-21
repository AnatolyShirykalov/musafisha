class City < ApplicationRecord
  has_many :halls, dependent: :destroy
end
