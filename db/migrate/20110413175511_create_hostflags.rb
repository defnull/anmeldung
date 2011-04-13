class CreateHostflags < ActiveRecord::Migration
  def self.up
    create_table :hostflags do |t|
      t.integer :host_id
      t.integer :flag_id
      t.string :description
      t.text :message

      t.timestamps
    end
  end

  def self.down
    drop_table :hostflags
  end
end
