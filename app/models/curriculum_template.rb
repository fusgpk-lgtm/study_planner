class CurriculumTemplate < ApplicationRecord
  has_many :template_items, dependent: :destroy
  has_many :textbooks, through: :template_items
  validates :name, :goal_school, presence: true
end
