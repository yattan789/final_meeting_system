class CreateAgendas < ActiveRecord::Migration[7.0]
  def change
    create_table :agendas do |t|
      t.integer :meting_id
      t.integer :user_id
      t.text :content

      t.timestamps
    end
  end
end
