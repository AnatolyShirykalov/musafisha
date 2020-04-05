class Intoclassics::PageComposer < ApplicationRecord
  belongs_to :page
  belongs_to :composer, class_name: 'Ohmymusic::Composer'
end
