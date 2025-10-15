class CreateStudyTimes < ActiveRecord::Migration[7.1]
  def change
    create_table :study_times do |t|
      t.references :student, null: false, foreign_key: true
      t.date :study_date
      t.integer :minutes

      t.timestamps
    end
  end
end
