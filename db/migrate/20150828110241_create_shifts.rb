class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.integer :user_id
      t.date :date
      t.integer :start_time, index: true

      t.timestamps null: false
    end
  end
end
