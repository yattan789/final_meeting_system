class CreateActions < ActiveRecord::Migration[7.0]
  def change
    create_table :actions do |t|
      t.belongs_to :mom, null: false, foreign_key: true
      t.text :description
      t.string :budget
      t.date :deadline
      t.string :appointed_person

      t.timestamps
    end
  end
end
