class ChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :meets, :type, :type2
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
