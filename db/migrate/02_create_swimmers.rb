class CreateSwimmers < ActiveRecord::Migration[5.2]
  def change
    create_table :swimmers do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.integer :team_id
      # t.string :specialty
    end
  end
end
