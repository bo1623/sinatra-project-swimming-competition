class Timings < ActiveRecord::Migration[5.2]
  def change
    create_table :timings do |t|
      t.time :personal_best
      t.integer :event_id
      t.integer :swimmer_id
    end
  end
end
