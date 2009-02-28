class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name, :null => false
      t.string :address, :null => false
      t.text :description
      t.float :latitude
      t.float :longitute

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
