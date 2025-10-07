class Student < ApplicationRecord
  validates :name, presence: true
  validates :goal_school, presence: true
  validates :start_date, presence: true
  validates :goal_date, presence: true
end
