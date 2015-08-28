class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :family_name
      t.string :first_name
      t.integer :age

      t.timestamps null: false
    end
  end
end
