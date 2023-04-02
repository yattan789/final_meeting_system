class ChangeColumnName2 < ActiveRecord::Migration[7.0]
  def change
    rename_column :agendas, :meting_id , :meet_id
  end
end
