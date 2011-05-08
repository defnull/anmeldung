class AddConfirmationPinToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :pin, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :users, :pin
  end
end
