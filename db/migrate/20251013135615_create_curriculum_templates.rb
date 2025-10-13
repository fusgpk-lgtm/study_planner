class CreateCurriculumTemplates < ActiveRecord::Migration[7.1]
  def change
    create_table :curriculum_templates do |t|
      t.string :name
      t.text :description
      t.string :goal_school

      t.timestamps
    end
  end
end
