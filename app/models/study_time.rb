class StudyTime < ApplicationRecord
  belongs_to :student
  validates :study_date, presence: true
  validates :minutes, numericality: { greater_than: 0 }
end
