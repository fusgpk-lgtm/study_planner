class Unit < ApplicationRecord
  belongs_to :textbook
  has_many :progresses, dependent: :destroy
end
