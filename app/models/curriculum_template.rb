class CurriculumTemplate < ApplicationRecord
  has_many :template_items, dependent: :destroy
  validates :name, :goal_school, presence: true
end
