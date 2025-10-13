class AddCurriculumTemplateIdToStudents < ActiveRecord::Migration[7.1]
  def change
    add_reference :students, :curriculum_template, null: false, foreign_key: true
  end
end
