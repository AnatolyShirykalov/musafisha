# Модуль с моделями из базы данных ohmymusic.ru
module Ohmymusic
  class Base < ActiveRecord::Base
    self.abstract_class = true

    establish_connection :"#{Rails.env}_ohmymusic"

    before_update :raise_readonly!
    before_create :raise_readonly!
    before_destroy :raise_readonly!

    def raise_readonly!
      raise 'Readonly db ohmymusic.ru'
    end
  end
end
