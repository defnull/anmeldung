class AddNumericIpToHosts < ActiveRecord::Migration
  def self.up
    add_column :hosts, :ip_numeric, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :hosts, :ip_numeric
  end
end
