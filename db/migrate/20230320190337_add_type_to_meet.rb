class AddTypeToMeet < ActiveRecord::Migration[7.0]
  def change
    add_column :meets, :type, :integer
  end
end
