class Subtype < ApplicationRecord
  has_many_and_belongs_to_many :cards
end
