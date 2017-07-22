module Neighborable
  extend ActiveSupport::Concern
  included do
    scope :next, lambda {|id| where("id > ?",id).order("id ASC") }
    scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }
  end

  def next
    self.class.next(self.id).first
  end

  def previous
    self.class.previous(self.id).first
  end
end
