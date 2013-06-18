class Entry < ActiveRecord::Base
  attr_accessible :name, :winner

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: { case_sensitive: false }, allow_nil: true
end
