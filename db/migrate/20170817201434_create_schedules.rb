class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.belongs_to :day
      t.date :day
      t.string :times
      t.string :title
      t.string :content
      t.boolean :check, default: false
      t.timestamps null: false
    end
    add_index :schedules, [:id, :day_id, :day], unique: true
  end
end
