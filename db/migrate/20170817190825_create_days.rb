class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.belongs_to :id
      t.date :day, null: false
      t.string :uid, null: false
      t.string :name, null: false
      t.text :goal
      t.text :diary
      t.float :score
      t.timestamps null: false
    end
    add_index :days, :day, unique: true
  end
end