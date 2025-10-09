class CreateProgresses < ActiveRecord::Migration[7.1]
  def change
    create_table :progresses do |t|
      t.references :student, null: false, foreign_key: true
      t.references :unit, null: false, foreign_key: true
      t.integer :status
      t.text :memo

      t.timestamps
    end
  end
end
