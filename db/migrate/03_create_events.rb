class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :stroke
      t.integer :distance
      t.string :gender
      t.string :division #division for age category
      t.string :name
      t.time :meet_record #let's try only one timing for the Events table, and for the meet record it can be a new swimmer called meet record or something
    end
  end
end
