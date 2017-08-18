class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.belongs_to :user
      t.string :uid, null: false 
      t.string :name, null: false
      t.date :day, null: false
      t.text :goal
      t.text :diary
      t.float :score
      t.timestamps null: false
    end
    add_index :days, [:day, :id, :uid], unique: true
  end
end