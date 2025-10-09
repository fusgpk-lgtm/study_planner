class Progress < ApplicationRecord
  belongs_to :student
  belongs_to :unit

  enum status: { not_started: 0, in_progress: 1, completed: 2 }
end
