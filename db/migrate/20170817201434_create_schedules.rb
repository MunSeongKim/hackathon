class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.belongs_to :day
      t.date :day
      t.string :times
      t.string :title
      t.string :content
      t.string :check
      t.timestamps null: false
    end
  end
end
