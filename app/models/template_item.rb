class TemplateItem < ApplicationRecord
  belongs_to :curriculum_template
  belongs_to :textbook

  validates :start_date, :end_date, presence: true
end
