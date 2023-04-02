class Changename3 < ActiveRecord::Migration[7.0]
  def self.up
    change_table :moms do |t|
      t.change :date, :string
    end
  end
  def self.down
    change_table :moms do |t|
      t.change :date, :datetime
    end
  end
end