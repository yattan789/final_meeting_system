class CreateMeets < ActiveRecord::Migration[7.0]
  def change
    create_table :meets do |t|
      t.integer :user_id
      t.datetime :date
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
