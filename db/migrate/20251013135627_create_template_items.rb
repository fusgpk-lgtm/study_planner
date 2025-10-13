class CreateTemplateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :template_items do |t|
      t.references :curriculum_template, null: false, foreign_key: true
      t.references :textbook, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
