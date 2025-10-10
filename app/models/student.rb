class Student < ApplicationRecord
  belongs_to :user
  has_many :progresses, dependent: :destroy
  has_many :units, through: :progresses

  validates :name, :goal_school, :start_date, :goal_date, presence: true

  def progress_percentage
    return 0 if start_date > Date.today || start_date >= goal_date
    return 100 if goal_date < Date.today

    total_days = (goal_date - start_date).to_i
    elapsed_days = (Date.today - start_date).to_i
    ((elapsed_days.to_f / total_days) * 100).round
  end
end
