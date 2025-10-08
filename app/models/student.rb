class Student < ApplicationRecord
  validates :name, presence: true
  validates :goal_school, presence: true
  validates :start_date, presence: true
  validates :goal_date, presence: true

  # 開始日から目標日までの期間に対する現在の進捗率を計算する
  def progress_percentage
    # 未来の予定や、期間が不正な場合は0を返す
    return 0 if start_date > Date.today || start_date >= goal_date
    # 既に目標日を過ぎている場合は100を返す
    return 100 if goal_date < Date.today

    total_days = (goal_date - start_date).to_i
    elapsed_days = (Date.today - start_date).to_i

    ((elapsed_days.to_f / total_days) * 100).round
  end
end
