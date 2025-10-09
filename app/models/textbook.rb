class Textbook < ApplicationRecord
  has_many :units, dependent: :destroy
end
