class CreateHosts < ActiveRecord::Migration
  def self.up
    create_table :hosts do |t|
      t.string :mac
      t.string :ip
      t.string :hostname
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :hosts
  end
end
