class DropRetailersTable < ActiveRecord::Migration
  def change
    drop_table :retailers
  end
end
