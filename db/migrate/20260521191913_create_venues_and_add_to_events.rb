class CreateVenuesAndAddToEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :venues do |t|
      t.string :name,     null: false
      t.string :address,  null: false
      t.integer :capacity

      t.timestamps
    end

    add_reference :events, :venue, null: true, foreign_key: true
  end
end