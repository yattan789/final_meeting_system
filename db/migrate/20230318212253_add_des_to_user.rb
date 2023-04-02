class AddDesToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :des, :string
  end
end
