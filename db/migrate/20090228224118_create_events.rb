class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :group_id,    :null => false, :options =>
        "CONSTRAINT fk_event_groups REFERENCES groups(id)"
      t.integer :location_id, :null => false, :options =>
        "CONSTRAINT fk_event_locations REFERENCES locations(id)"
      t.string :name, :null => false
      t.text :description
      t.datetime :start_time, :null => false
      t.datetime :end_time

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
