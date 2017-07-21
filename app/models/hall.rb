class Hall < ApplicationRecord
  has_many :concerts

  has_attached_file :icon
  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\Z/
end
