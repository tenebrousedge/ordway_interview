class CreateSeats < ActiveRecord::Migration[6.1]
  def change
    create_table :seats do |t|
      t.string :row
      t.integer :column
      t.string :status

      t.timestamps
    end
  end
end
