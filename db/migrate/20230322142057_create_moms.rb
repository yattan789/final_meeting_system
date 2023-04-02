class CreateMoms < ActiveRecord::Migration[7.0]
  def change
    create_table :moms do |t|
      t.datetime :date
      t.string :calledby
      t.text :descrption
      t.string :title
      t.string :venue
      t.integer :callby_id
      t.integer :meet_id
      t.string :attendby
      t.text :report

      t.timestamps
    end
  end
end
