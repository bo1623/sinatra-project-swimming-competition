class CreateSwimmers < ActiveRecord::Migration
  def change
    create_table :swimmers do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.integer :team_id
    end
  end
end
