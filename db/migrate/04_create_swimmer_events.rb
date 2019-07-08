class CreateSwimmerEvents < ActiveRecord::Migration
  def change
    create_table :swimmer_events do |t|
      t.integer :swimmer_id
      t.integer :event_id
    end
  end
end
