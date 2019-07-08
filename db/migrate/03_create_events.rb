class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :stroke
      t.integer :distance
      t.string :gender
      t.string :division #division for age category
    end
  end
end
