class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.string :name
      t.string :goal_school
      t.date :start_date
      t.date :goal_date
      t.timestamps
    end
  end
end
